import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hawk/appconsts.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/services/firestore_service.dart';
import 'package:hawk/widgets/gradientbutton.dart';
import 'package:hawk/widgets/gradientstack.dart';

class RejectScreen extends StatelessWidget {
  const RejectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientStack(
      gradients: const [AppGradients.screenBg],
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConsts.marginX),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Your account has been rejected",
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset(
                    'assets/images/rejected.png',
                    width: 500, // Specify your desired width
                    height: 400, // Specify your desired height
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      FirestoreService.updateFcmToken("");
                    },
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
