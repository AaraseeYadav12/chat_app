import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // EMAIL LOGIN
  Future<UserCredential> loginWithEmail(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // GOOGLE LOGIN
  Future<User?> signInWithGoogle() async {

    await _googleSignIn.signOut(); // force account selection

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
    await _auth.signInWithCredential(credential);

    User? user = userCredential.user;

    // 🔥 SAVE USER IN FIRESTORE
    if (user != null) {

      await _firestore.collection("users").doc(user.uid).set({
        "uid": user.uid,
        "name": user.displayName ?? "",
        "email": user.email ?? "",
        "avatar": user.photoURL ?? "",
        "status": "Online",
        "createdAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    return user;
  }

  // GET CURRENT USER
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}