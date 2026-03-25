import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppointmentHistoryList extends StatefulWidget {
  const AppointmentHistoryList({Key? key}) : super(key: key);

  @override
  State<AppointmentHistoryList> createState() => _AppointmentHistoryListState();
}

class _AppointmentHistoryListState extends State<AppointmentHistoryList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
  }

  String _dateFormatter(String timestamp) {
    try {
      return DateFormat('dd-MM-yyyy').format(DateTime.parse(timestamp));
    } catch (e) {
      return '';
    }
  }

  Future<void> deleteAppointment(String docID) async {
    if (user?.email != null) {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(user!.email)
          .collection('all')
          .doc(docID)
          .delete();
    }
  }

  String _timeFormatter(String timestamp) {
    try {
      return DateFormat('kk:mm').format(DateTime.parse(timestamp));
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null || user!.email == null) {
      return const Center(child: Text('User not signed in'));
    }
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .doc(user!.email)
            .collection('all')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          return docs.isEmpty
              ? Text(
            'History Appears here...',
            style: GoogleFonts.lato(
              color: Colors.grey,
              fontSize: 18,
            ),
          )
              : ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final document = docs[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueGrey[50],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document['doctor'],
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _dateFormatter(
                              document['date'].toDate().toString()),
                          style: GoogleFonts.lato(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          );
        },
      ),
    );
  }
}