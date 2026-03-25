import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/features/auth/screens/signIn.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();
  final FocusNode f3 = FocusNode();
  final FocusNode f4 = FocusNode();

  @override
  void dispose() {
    _displayName.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    f1.dispose(); f2.dispose(); f3.dispose(); f4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Create Account',
                  style: GoogleFonts.lato(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.indigo[900],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Join HealthBridge to manage your appointments.',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),

                // Name Field
                _buildInputLabel("Full Name"),
                _buildTextField(
                  controller: _displayName,
                  focusNode: f1,
                  hint: "John Doe",
                  icon: Icons.person_outline,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(f2),
                ),

                const SizedBox(height: 20),

                // Email Field
                _buildInputLabel("Email Address"),
                _buildTextField(
                  controller: _emailController,
                  focusNode: f2,
                  hint: "name@email.com",
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(f3),
                ),

                const SizedBox(height: 20),

                // Password Field
                _buildInputLabel("Password"),
                _buildTextField(
                  controller: _passwordController,
                  focusNode: f3,
                  hint: "••••••••",
                  icon: Icons.lock_outline_rounded,
                  isPassword: true,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(f4),
                ),

                const SizedBox(height: 20),

                // Confirm Password Field
                _buildInputLabel("Confirm Password"),
                _buildTextField(
                  controller: _passwordConfirmController,
                  focusNode: f4,
                  hint: "••••••••",
                  icon: Icons.lock_reset_rounded,
                  isPassword: true,
                ),

                const SizedBox(height: 35),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[900],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      shadowColor: Colors.indigo.withOpacity(0.4),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showLoaderDialog(context);
                        _registerAccount();
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: GoogleFonts.lato(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                    TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignIn())),
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.lato(color: Colors.indigo[700], fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- UI Helpers ---

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(label, style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: Colors.black87)),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    FocusNode? focusNode,
    bool isPassword = false,
    TextInputType? keyboardType,
    void Function(String)? onFieldSubmitted,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isPassword,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.indigo[300]),
        hintText: hint,
        hintStyle: GoogleFonts.lato(color: Colors.grey[350]),
        filled: true,
        fillColor: Colors.indigo.withOpacity(0.03),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.indigo, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Field cannot be empty';
        if (controller == _emailController && !value.contains('@')) return 'Enter a valid email';
        if (controller == _passwordController && value.length < 8) return 'Min 8 characters';
        if (controller == _passwordConfirmController && value != _passwordController.text) return 'Passwords do not match';
        return null;
      },
    );
  }

  // --- Logic ---

  void _showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator(color: Colors.indigo)),
    );
  }

  Future<void> _registerAccount() async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final user = credential.user;
      if (user != null) {
        await user.updateDisplayName(_displayName.text);
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': _displayName.text,
          'email': user.email,
          'createdAt': Timestamp.now(),
        }, SetOptions(merge: true));

        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      }
    } catch (e) {
      Navigator.pop(context); // Close loader
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.redAccent, content: Text(e.toString())),
      );
    }
  }
}