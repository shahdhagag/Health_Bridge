import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/features/auth/screens/register.dart';
import '../authFunctions/firebase_functions.dart';
import 'change_password.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFunctions _functions = FirebaseFunctions();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // 1. Keeping your Image
                Image.asset(
                  'assets/vector-doc2.jpg',
                  height: 220, // Adjusted for better fit
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 10),

                // 2. Modern Header
                Text(
                  'Welcome Back!',
                  style: GoogleFonts.lato(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.indigo[900],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please sign in to continue',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.grey[500],
                  ),
                ),

                const SizedBox(height: 40),

                // 3. Refined Input Fields
                _buildTextField(
                  controller: _emailController,
                  focusNode: f1,
                  hint: "Email Address",
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(f2),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your email';
                    if (!emailValidate(value)) return 'Enter a valid email';
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _passwordController,
                  focusNode: f2,
                  hint: "Password",
                  icon: Icons.lock_outline_rounded,
                  isPassword: true,
                  validator: (value) => (value == null || value.isEmpty) ? 'Please enter your password' : null,
                ),

                // 4. Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.lato(
                        color: Colors.indigo[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 5. Primary Action Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[900],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 4,
                      shadowColor: Colors.indigo.withOpacity(0.4),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showLoading(context);
                        _signInWithEmailAndPassword();
                      }
                    },
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 6. Modern Social Login
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Or login with", style: GoogleFonts.lato(color: Colors.grey[400])),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Login
                    _socialButton(
                      icon: Icons.g_mobiledata,
                      color: Colors.red[700],
                        onTap: () async {
                          _showLoading(context);
                          await _functions.signInWithGoogle(context);
                         // Navigator.pop(context) ;//is handled inside your FirebaseFunctions catch block
                        }                    ),

                    const SizedBox(width: 25),

                    // Facebook Login
                    _socialButton(
                      icon: Icons.facebook,
                      color: Colors.blue[900],
                      onTap: () => _functions.signInWithFacebook(context),
                      // Navigator.pop(context) is handled inside your FirebaseFunctions catch block
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // 7. Re-styled Signup Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New to HealthBridge? ",
                      style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Register())
                      ),
                      child: Text(
                        'Create Account',
                        style: GoogleFonts.lato(
                          color: Colors.indigo[700],
                          fontWeight: FontWeight.w700,
                        ),
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

  // Helper for Input Fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    FocusNode? focusNode,
    bool isPassword = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onFieldSubmitted,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.indigo[300]),
        hintText: hint,
        hintStyle: GoogleFonts.lato(color: Colors.grey[400], fontWeight: FontWeight.normal),
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
    );
  }

  Widget _socialButton({
    required IconData icon,
    required Color? color,
    required VoidCallback onTap, // Add this
  }) {
    return InkWell( // Wrap with InkWell for touch feedback
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }

  void _showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator(color: Colors.indigo)),
    );
  }

  bool emailValidate(String email) => RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

  void _signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } catch (e) {
      Navigator.pop(context); // Close loader
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.redAccent, content: Text("Login Failed: ${e.toString()}")),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    f1.dispose();
    f2.dispose();
    super.dispose();
  }
}