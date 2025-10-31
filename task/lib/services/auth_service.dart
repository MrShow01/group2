// lib/services/auth_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ---------- Sign Up ----------
  Future<String?> register({
    required String email,
    required String password,
    required String name,
    required String itGrade,
    required String csGrade,
    required String isGrade,
    required String tsGrade,
  }) async {
    try {
      // Create user with Firebase Auth
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Get UID
      final uid = userCredential.user?.uid;

      // Build Firestore document ID using name + uid
      final docId = '${name}_$uid';

      // Store user data in Firestore
      await _firestore.collection('users').doc(docId).set({
        'uid': uid,
        'email': email,
        'name': name,
        'it grade': itGrade,
        'cs grade': csGrade,
        'is grade': isGrade,
        'ts grade': tsGrade,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // ---------- Sign In ----------
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // ---------- Get Current User ----------
  User? get currentUser => _auth.currentUser;
}
