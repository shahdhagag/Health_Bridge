import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/features/appointment/screens/bookingScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfile extends StatefulWidget {
  final String doctor;

  const DoctorProfile({Key? key, required this.doctor}) : super(key: key);
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  Future<void> _launchCaller(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.doctor.isEmpty) {
      return const Scaffold(body: Center(child: Text('Doctor not found')));
    }
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light grey background for contrast
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.indigo),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .where('name', isEqualTo: widget.doctor)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Doctor data missing"));
          }

          var doc = snapshot.data!.docs[0];

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Header Section
                _buildProfileHeader(doc),

                const SizedBox(height: 25),

                // Main Content Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildInfoCard(
                        icon: Icons.description_outlined,
                        title: "About",
                        content: doc['specification'],
                      ),
                      const SizedBox(height: 15),
                      _buildInfoCard(
                        icon: Icons.location_on_outlined,
                        title: "Clinic Location",
                        content: doc['address'],
                      ),
                      const SizedBox(height: 15),
                      _buildScheduleCard(doc),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Booking Button
                _buildBookingButton(doc),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(DocumentSnapshot doc) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 5),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 5,
              )
            ],
          ),
          child: CircleAvatar(
            radius: 75,
            backgroundColor: Colors.grey[200],
            backgroundImage: NetworkImage(doc['image']),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          doc['name'],
          style: GoogleFonts.lato(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.indigo[900],
          ),
        ),
        Text(
          doc['type'],
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.indigoAccent,
          ),
        ),
        const SizedBox(height: 12),
        // Rating Chips
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              Icon(
                Icons.star_rounded,
                color: i < (doc['rating'] ?? 0) ? Colors.orangeAccent : Colors.grey[300],
                size: 24,
              ),
            const SizedBox(width: 8),
            Text(
              "(${doc['rating']}.0)",
              style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: Colors.grey[600]),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard({required IconData icon, required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.indigo, size: 20),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.indigo[900]),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: GoogleFonts.lato(fontSize: 15, color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(DocumentSnapshot doc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time_rounded, color: Colors.indigo, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    "Working Hours",
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.indigo[900]),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "Today: ${doc['openHour']} - ${doc['closeHour']}",
                style: GoogleFonts.lato(fontSize: 15, color: Colors.black54),
              ),
            ],
          ),
          // Call Button
          IconButton.filledTonal(
            onPressed: () => _launchCaller("tel:${doc['phone']}"),
            icon: const Icon(Icons.phone_forwarded_rounded),
            style: IconButton.styleFrom(backgroundColor: Colors.indigo[50], foregroundColor: Colors.indigo),
          )
        ],
      ),
    );
  }

  Widget _buildBookingButton(DocumentSnapshot doc) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          shadowColor: Colors.indigo.withOpacity(0.4),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingScreen(doctor: doc['name']),
            ),
          );
        },
        child: Text(
          "Book Appointment Now",
          style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}