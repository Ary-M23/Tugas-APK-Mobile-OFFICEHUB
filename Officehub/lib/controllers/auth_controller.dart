import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Officehub/controllers/database_helper.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //await DatabaseHelper().insertUser(email, userCredential.user!.uid);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
      rethrow; // rethrow the exception so it can be caught in the calling method
    } catch (e) {
      print('General Exception: ${e.toString()}');
      rethrow; // rethrow the exception so it can be caught in the calling method
    }
  }

  Future<User?> registerUser(
      String email, String password, String displayName) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      try {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'displayName': displayName,
          'email': email,
          'role': 'UI Designer',
        });
      } catch (e) {
        print('Firestore Write Fail: ${e.toString()}');
        return null;
      }

      await userCredential.user!.updateDisplayName(displayName);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
      return null;
    } catch (e) {
      print('General Exception: ${e.toString()}');
      return null;
    }
  }

  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      if (userDoc.exists) {
        return data['role'];
      } else {
        print('User does not exist');
        return null;
      }
    } catch (e) {
      print('Error getting user role: $e');
      return null;
    }
  }
}
