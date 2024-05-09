import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hawk/services/firestore_service.dart';
import 'package:hawk/services/snack.dart';

class AuthService {
  static signUpUser(String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirestoreService.saveUser(name, email, userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Snack("Error", "The password is too weak", ContentType.failure, context);
      } else if (e.code == 'email-already-in-use') {
        Snack("Error", "The email is already in use try logging in", ContentType.failure, context);
      }
    } catch (e) {
      Snack("Error", e.toString(), ContentType.failure, context);
    }
  }

  static signInUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Snack("Success", "You are logged in", ContentType.success, context);
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code}");
      if (e.code == 'invalid-credential') {
        Snack("Invalid Credentials", "Either there is no account for this email or the password is wrong",
            ContentType.failure, context);
      }
    } catch (e) {
      Snack("Error", e.toString(), ContentType.failure, context);
    }
  }
}
