import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool agree = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // 🔹 Gradient Avatar
            Container(
              width: size.width * 0.28,
              height: size.width * 0.28,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.person_add_alt_1,
                  size: 70,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Create Account",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 30),

            _buildInputField(
              label: "Full Name",
              icon: Icons.person,
              controller: nameCtrl,
            ),
            const SizedBox(height: 15),

            _buildInputField(
              label: "Email",
              icon: Icons.email,
              controller: emailCtrl,
            ),
            const SizedBox(height: 15),

            IntlPhoneField(
              decoration: InputDecoration(
                labelText: "Phone Number",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              initialCountryCode: "IN",
            ),
            const SizedBox(height: 15),

            _buildPasswordField(
              label: "Password",
              controller: passwordCtrl,
              obscure: !showPassword,
              show: showPassword,
              onToggle: () => setState(() => showPassword = !showPassword),
            ),
            const SizedBox(height: 15),

            _buildPasswordField(
              label: "Confirm Password",
              controller: confirmPasswordCtrl,
              obscure: !showConfirmPassword,
              show: showConfirmPassword,
              onToggle: () =>
                  setState(() => showConfirmPassword = !showConfirmPassword),
            ),
            const SizedBox(height: 15),

            Row(
              children: [
                Checkbox(
                  value: agree,
                  onChanged: (val) => setState(() => agree = val!),
                ),
                const Text("I agree to Terms & Conditions"),
              ],
            ),
            const SizedBox(height: 25),

            // 🔹 SIGN UP BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _emailSignup,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: const [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("OR"),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 GOOGLE SIGN UP
            _socialButton(
              label: "Sign Up with Google",
              icon: Image.network(
                "https://cdn.iconscout.com/icon/free/png-256/free-google-470-675827.png",
                height: 24,
              ),
              borderColor: Colors.deepPurple,
              textColor: Colors.deepPurple,
              onPressed: _googleSignup,
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= AUTH LOGIC =================

  Future<void> _emailSignup() async {
    if (!agree) {
      _showMsg("Accept Terms & Conditions");
      return;
    }

    if (passwordCtrl.text != confirmPasswordCtrl.text) {
      _showMsg("Passwords do not match");
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      _showMsg(e.toString());
    }
  }

  Future<void> _googleSignup() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      _showMsg("Google Sign-In Failed");
    }
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // ================= UI HELPERS =================

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required bool show,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(show ? Icons.visibility : Icons.visibility_off),
          onPressed: onToggle,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Widget _socialButton({
    required String label,
    required Widget icon,
    required Color borderColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 16, color: textColor),
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
