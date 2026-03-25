import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
class UpdateUserDetails extends StatefulWidget {
  final String label;
  final String field;
  final String currentValue; // Added this

  const UpdateUserDetails({
    Key? key,
    required this.label,
    required this.field,
    required this.currentValue
  }) : super(key: key);

  @override
  State<UpdateUserDetails> createState() => _UpdateUserDetailsState();
}

class _UpdateUserDetailsState extends State<UpdateUserDetails> {
  late TextEditingController _textController;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.currentValue);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> updateData() async {
    if (user == null || _textController.text.isEmpty) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .set({widget.field: _textController.text}, SetOptions(merge: true));

      if (widget.field == 'name') {
        await user!.updateDisplayName(_textController.text);
      }

      // إغلاق الصفحة الحالية
      Navigator.pop(context);

      // عرض SnackBar منسق
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                '${widget.label} updated successfully!',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          backgroundColor: Colors.indigo, // لون متناسق مع تطبيقك
          behavior: SnackBarBehavior.floating, // يجعله يظهر بشكل عائم (Modern)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // زوايا دائرية
          ),
          margin: const EdgeInsets.all(16), // مسافة من حواف الشاشة
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // عرض SnackBar في حالة الخطأ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating ${widget.label}: $e'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.indigo),
        title: Text("Edit ${widget.label}", style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              autofocus: true,
              style: GoogleFonts.lato(fontSize: 18),
              decoration: InputDecoration(
                labelText: "Enter ${widget.label}",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.indigo, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: updateData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'Save Changes',
                style: GoogleFonts.lato(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}