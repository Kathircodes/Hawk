import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/screens/admin/home_screen.dart';
import 'package:hawk/screens/employee/home_screen.dart';
import 'package:hawk/screens/login_screen.dart';
import 'package:hawk/screens/reject_screen.dart';
import 'package:hawk/screens/wait_screen.dart';
import 'package:hawk/services/firestore_service.dart';
import 'package:hawk/widgets/gradientstack.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return FutureBuilder<List<String>>(
              future: FirestoreService.getStatusandRole(),
              builder: (context, statusSnapshot) {
                if (statusSnapshot.connectionState == ConnectionState.waiting) {
                  return const GradientStack(
                    gradients: [AppGradients.screenBg],
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(child: CircularProgressIndicator()),
                    ),
                  );
                } else if (statusSnapshot.hasData) {
                  var status = statusSnapshot.data![0];
                  var role = statusSnapshot.data![1];

                  if (status == "waiting") {
                    return const WaitScreen();
                  } else if (status == "rejected") {
                    return const RejectScreen();
                  } else {
                    if (role == "employee") {
                      return const EmpHomeScreen();
                    } else {
                      return const AdHomeScreen();
                    }
                  }
                } else if (statusSnapshot.hasError) {
                  return Text("Error: ${statusSnapshot.error}");
                } else {
                  return const WaitScreen();
                }
              },
            );
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
