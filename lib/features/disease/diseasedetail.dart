import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseaseDetail extends StatefulWidget {
  final String disease;
  const DiseaseDetail({Key? key, required this.disease}) : super(key: key);
  @override
  _DiseaseDetailState createState() => _DiseaseDetailState();
}

class _DiseaseDetailState extends State<DiseaseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.disease,
          style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('disease')
            .where('Name', isEqualTo: widget.disease)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          var document = snapshot.data!.docs.first;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Header Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: Colors.blue[50],
                  child: Column(
                    children: [
                      const Icon(Icons.info_outline_rounded, size: 40, color: Colors.blue),
                      const SizedBox(height: 10),
                      Text(
                        document['Description'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(fontSize: 16, color: Colors.black87, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Detailed Sections
                _buildInfoSection(
                  title: 'How does it spread?',
                  content: document['Spread'],
                  icon: Icons.record_voice_over_rounded,
                  color: Colors.orange,
                ),
                _buildInfoSection(
                  title: 'Symptoms',
                  content: document['Symtomps'],
                  icon: Icons.thermostat_rounded,
                  color: Colors.red,
                ),
                _buildInfoSection(
                  title: 'Medical Warning Signs',
                  content: document['Warning'],
                  icon: Icons.warning_amber_rounded,
                  color: Colors.red[900]!,
                  isWarning: true,
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
    bool isWarning = false,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isWarning ? Colors.red[50] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: isWarning ? Colors.red[100]! : Colors.grey[200]!),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ],
          ),
          const Divider(height: 25),
          Text(
            content,
            style: GoogleFonts.lato(fontSize: 16, color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }
}