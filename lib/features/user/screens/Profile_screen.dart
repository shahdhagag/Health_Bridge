import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart'; // المكتبة الجديدة
import 'package:health_and_doctor_appointment/features/appointment/screens/appointmentHistoryList.dart';
import 'package:health_and_doctor_appointment/features/user/screens/Settings_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    _loadSavedImage(); // تحميل الصورة المحفوظة عند فتح الصفحة
  }

  // تحميل مسار الصورة من ذاكرة الهاتف
  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('user_profile_path_${user?.uid}');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _pickedImage = File(imagePath);
      });
    }
  }

  // حفظ مسار الصورة في ذاكرة الهاتف
  Future<void> _saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_profile_path_${user?.uid}', path);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50
    );

    if (pickedFile == null) return;

    setState(() {
      _pickedImage = File(pickedFile.path);
    });

    // حفظ المسار في ذاكرة الهاتف
    await _saveImagePath(pickedFile.path);

    // عرض SnackBar منسق واحترافي
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.photo_library_rounded, color: Colors.white),
            SizedBox(width: 12),
            Text(
              "Profile photo updated!", // تغيير الكلمة لتبدو أفضل
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        backgroundColor: Colors.indigo,
        behavior: SnackBarBehavior.floating, // لجعلها عائمة
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(body: Center(child: Text("Please Log In")));
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
      builder: (context, snapshot) {
        Map<String, dynamic> userData = {};
        if (snapshot.hasData && snapshot.data!.exists) {
          userData = snapshot.data!.data() as Map<String, dynamic>;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildHeader(
                  userData['name'] ?? user?.displayName ?? 'User Name',
                  userData['profileImage'],
                ),
                const SizedBox(height: 60),
                _buildInfoCard(userData['phone'] ?? 'Add Phone Number'),
                _buildBioCard(userData['bio'] ?? 'No Bio Added'),
                _buildAppointmentHistory(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(String displayName, String? profileImageUrl) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.indigo, Colors.indigoAccent],
            ),
          ),
          child: SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const UserSettings())
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 110,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _pickedImage != null
                            ? FileImage(_pickedImage!) as ImageProvider
                            : (profileImageUrl != null
                            ? NetworkImage(profileImageUrl)
                            : const AssetImage('assets/person.jpg') as ImageProvider),
                      ),
                    ),
                    const Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.indigo,
                        radius: 18,
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                displayName,
                style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Widgets المعلومات (بقيت كما هي) ---

  Widget _buildInfoCard(String phone) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blueGrey[50], borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          _rowInfo(Icons.mail_rounded, Colors.red[900]!, user?.email ?? 'No Email'),
          const Divider(height: 30),
          _rowInfo(Icons.phone_iphone_rounded, Colors.blue[800]!, phone),
        ],
      ),
    );
  }

  Widget _rowInfo(IconData icon, Color color, String text) {
    return Row(
      children: [
        CircleAvatar(radius: 16, backgroundColor: color, child: Icon(icon, color: Colors.white, size: 16)),
        const SizedBox(width: 15),
        Expanded(child: Text(text, style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600))),
      ],
    );
  }

  Widget _buildBioCard(String bio) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blueGrey[50], borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.edit_note_rounded, color: Colors.indigo),
            const SizedBox(width: 10),
            Text("Bio", style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 10),
          Text(bio, style: GoogleFonts.lato(fontSize: 15, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildAppointmentHistory() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blueGrey[50], borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Appointment History", style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () => Navigator.pushNamed(context, '/MyAppointments'), child: const Text("View All"))
          ]),
          const SizedBox(height: 10),
          const AppointmentHistoryList(),
        ],
      ),
    );
  }
}