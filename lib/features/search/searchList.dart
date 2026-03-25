import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/features/doctor/screens/doctorProfile.dart';

class SearchList extends StatefulWidget {
  final String searchKey;
  const SearchList({Key? key, required this.searchKey}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar بسيط جداً وبدون سهم العودة
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // إزالة سهم العودة تلقائياً
        title: Text(
          'Doctors',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(strokeWidth: 2));
          }

          final filteredDocs = snapshot.data!.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final String name = (data['name'] ?? '').toString().toLowerCase();
            final String type = (data['type'] ?? '').toString().toLowerCase();
            final String search = widget.searchKey.toLowerCase().trim();
            return name.contains(search) || type.contains(search);
          }).toList();

          if (filteredDocs.isEmpty) {
            return _buildSimpleEmptyState();
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: filteredDocs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              final doctor = filteredDocs[index].data() as Map<String, dynamic>;
              return _buildSimpleDoctorTile(doctor);
            },
          );
        },
      ),
    );
  }

  // تصميم "Tile" بسيط وواضح
  Widget _buildSimpleDoctorTile(Map<String, dynamic> doctor) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DoctorProfile(doctor: doctor['name'])),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[50], // رمادي فاتح جداً
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // صورة دائرية بسيطة
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
              backgroundImage: doctor['image'] != null
                  ? NetworkImage(doctor['image'])
                  : const AssetImage('assets/person.jpg') as ImageProvider,
            ),
            const SizedBox(width: 15),
            // نصوص واضحة
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor['name'] ?? 'Dr. Name',
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor['type'] ?? 'Specialist',
                    style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // أيقونة بسيطة للتقييم
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orangeAccent, size: 16),
                const SizedBox(width: 4),
                Text(
                  "${doctor['rating'] ?? 5.0}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // حالة "لا يوجد نتائج" بسيطة جداً
  Widget _buildSimpleEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/error-404.jpg', height: 150),
          const SizedBox(height: 20),
          Text(
            'No matches found',
            style: GoogleFonts.lato(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}