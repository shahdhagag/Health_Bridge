import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/features/user/screens/updateUserDetails.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key}) : super(key: key);

  static const List<Map<String, String>> settingsItems = [
    {'label': 'Name', 'field': 'name'},
    {'label': 'Email', 'field': 'email'},
    {'label': 'Mobile Number', 'field': 'phone'},
    {'label': 'Bio', 'field': 'bio'},
    {'label': 'Birthday', 'field': 'birthDate'},
    {'label': 'City', 'field': 'city'},
  ];

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) return const Center(child: Text('Please Log In'));

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final userData = snapshot.data!.data() as Map<String, dynamic>? ?? {};

        return ListView.builder(
          itemCount: settingsItems.length,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          itemBuilder: (context, index) {
            final item = settingsItems[index];
            final String currentVal = userData[item['field']]?.toString() ?? 'Not Added';

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateUserDetails(
                      label: item['label']!,
                      field: item['field']!,
                      currentValue: currentVal == 'Not Added' ? '' : currentVal,
                    ),
                  ),
                ),
                borderRadius: BorderRadius.circular(15),
                child: Ink(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['label']!,
                        style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                        child: Text(
                          currentVal,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(fontSize: 15, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}