import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyAppointmentList extends StatefulWidget {
  const MyAppointmentList({Key? key}) : super(key: key);

  @override
  State<MyAppointmentList> createState() => _MyAppointmentListState();
}

class _MyAppointmentListState extends State<MyAppointmentList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? _documentID;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
  }

  Future<void> deleteAppointment(String docID) async {
    if (user?.email != null) {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(user!.email)
          .collection('pending')
          .doc(docID)
          .delete();
    }
  }

  String _dateFormatter(String timestamp) {
    try {
      return DateFormat('dd-MM-yyyy').format(DateTime.parse(timestamp));
    } catch (e) {
      return '';
    }
  }

  String _timeFormatter(String timestamp) {
    try {
      return DateFormat('kk:mm').format(DateTime.parse(timestamp));
    } catch (e) {
      return '';
    }
  }

  void showAlertDialog(BuildContext context, String documentID) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // زوايا دائرية ناعمة
        ),
        title: Column(
          children: [
            const Icon(
              Icons.delete_forever_rounded,
              color: Colors.redAccent,
              size: 50,
            ),
            const SizedBox(height: 15),
            Text(
              "Confirm Delete",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        content: Text(
          "Are you sure you want to delete this appointment? This action cannot be undone.",
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly, // توزيع الأزرار بشكل متساوٍ
        actions: [
          // زر الإلغاء
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
              "Cancel",
              style: GoogleFonts.lato(
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          // زر التأكيد (تصميم بارز)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            ),
            child: Text(
              "Yes, Delete",
              style: GoogleFonts.lato(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              deleteAppointment(documentID);
              Navigator.of(context).pop();
              // يمكنك إضافة SnackBar هنا لتأكيد الحذف للمستخدم
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Appointment deleted")),
              );
            },
          ),
        ],
      ),
    );
  }

  bool _checkDiff(DateTime date) {
    var diff = DateTime.now().difference(date).inHours;
    return diff > 2;
  }

  bool _compareDate(String date) {
    return _dateFormatter(DateTime.now().toString())
        .compareTo(_dateFormatter(date)) ==
        0;
  }

  @override
  Widget build(BuildContext context) {
    if (user?.email == null) {
      return const Center(child: Text('User not signed in'));
    }
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .doc(user!.email)
            .collection('pending')
            .orderBy('date')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          return docs.isEmpty
              ? Center(
            child: Text(
              'No Appointment Scheduled',
              style: GoogleFonts.lato(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
          )
              : ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final document = docs[index];
              if (_checkDiff(document['date'].toDate())) {
                deleteAppointment(document.id);
              }
              return Card(
                elevation: 2,
                child: InkWell(
                  onTap: () {},
                  child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            document['doctor'],
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          _compareDate(
                              document['date'].toDate().toString())
                              ? "TODAY"
                              : "",
                          style: GoogleFonts.lato(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 0),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        _dateFormatter(
                            document['date'].toDate().toString()),
                        style: GoogleFonts.lato(),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, right: 10, left: 16),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Patient name: " + document['name'],
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Time: " +
                                      _timeFormatter(
                                        document['date']
                                            .toDate()
                                            .toString(),
                                      ),
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              tooltip: 'Delete Appointment',
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                _documentID = document.id;
                                showAlertDialog(context,document.id );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}