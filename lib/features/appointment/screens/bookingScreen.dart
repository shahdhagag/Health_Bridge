import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final String doctor;
  const BookingScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // Focus Nodes
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();

  DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String? dateUTC;
  String? date_Time;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    _doctorController.text = "Dr. ${widget.doctor}";
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
        _dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
        dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (selectedTime != null) {
      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(
        selectedTime,
        alwaysUse24HourFormat: false,
      );

      setState(() {
        _timeController.text = formattedTime;
        date_Time = "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  // --- التعديل هنا في نافذة التنبيه ---
  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Booking Successful!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[900],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Your appointment has been registered.\nThank you for choosing our service.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      // إغلاق الدايلوج والعودة للصفحة السابقة
                      Navigator.pop(context); // يغلق الـ Dialog
                      Navigator.pop(context); // يخرج من صفحة الـ Booking
                    },
                    child: Text(
                      "Great, Thanks!",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _createAppointment() async {
    try {
      if (user?.email == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not logged in.')));
        return;
      }
      if (dateUTC == null || date_Time == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select date and time.')));
        return;
      }

      final appointmentDate = DateTime.parse('$dateUTC $date_Time:00');

      var appointmentData = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'description': _descriptionController.text,
        'doctor': _doctorController.text,
        'date': appointmentDate,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(user!.email)
          .collection('pending')
          .add(appointmentData);

      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(user!.email)
          .collection('all')
          .add(appointmentData);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Book Appointment',
            style: GoogleFonts.lato(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildImageHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Doctor Info"),
                      _buildTextField(
                        controller: _doctorController,
                        label: 'Consulting Doctor',
                        icon: Icons.medical_services_outlined,
                        readOnly: true,
                      ),
                      _buildSectionTitle("Patient Information"),
                      _buildTextField(
                        controller: _nameController,
                        focusNode: f1,
                        label: 'Patient Full Name',
                        icon: Icons.person_outline_rounded,
                        validator: (v) => v!.isEmpty ? 'Name is required' : null,
                        nextFocus: f2,
                      ),
                      _buildTextField(
                        controller: _phoneController,
                        focusNode: f2,
                        label: 'Mobile Number',
                        icon: Icons.phone_android_rounded,
                        keyboardType: TextInputType.phone,
                        validator: (v) => v!.length < 10 ? 'Enter a valid phone number' : null,
                        nextFocus: f3,
                      ),
                      _buildTextField(
                        controller: _descriptionController,
                        focusNode: f3,
                        label: 'Description / Symptoms',
                        icon: Icons.note_add_outlined,
                        maxLines: 3,
                      ),
                      _buildSectionTitle("Select Schedule"),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDateTimePicker(
                              controller: _dateController,
                              label: 'Date',
                              icon: Icons.calendar_today_rounded,
                              onTap: () => selectDate(context),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: _buildDateTimePicker(
                              controller: _timeController,
                              label: 'Time',
                              icon: Icons.access_time_rounded,
                              onTap: () => selectTime(context),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      _buildSubmitButton(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // UI Helpers (تبقى كما هي)
  Widget _buildImageHeader() {
    return Container(
      height: 180,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: const DecorationImage(image: AssetImage('assets/appointment.jpg'), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(title, style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo[900])),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    FocusNode? focusNode,
    FocusNode? nextFocus,
    bool readOnly = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        maxLines: maxLines,
        validator: validator,
        keyboardType: keyboardType,
        style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.indigo, size: 20),
          hintText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        ),
        onFieldSubmitted: (_) {
          if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
        },
      ),
    );
  }

  Widget _buildDateTimePicker({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.indigo, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(controller.text.isEmpty ? label : controller.text)),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await _createAppointment();
            showAlertDialog(context);
          }
        },
        child: Text("Confirm Booking",
            style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}