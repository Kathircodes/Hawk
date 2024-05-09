import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hawk/appcolors.dart';
import 'package:hawk/appconsts.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/models/user.dart';
import 'package:hawk/services/firestore_service.dart';
import 'package:hawk/widgets/gradientbutton.dart';
import 'package:hawk/widgets/gradientstack.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GradientStack(
      gradients: const [AppGradients.screenBg],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConsts.marginX),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.96,
                  decoration: BoxDecoration(
                    color: AppColors.chipBlue,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${user.name}',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Email ID: ${user.email}',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Employee Id: ${user.employeeId}',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Role: ${user.role}',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  width: MediaQuery.of(context).size.width * 0.96,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.chipBlue,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expected Start Time: ${user.startTime}',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Expected Stop Time: ${user.stopTime}',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Start Date: ${user.startDate}',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'In Office: ${user.inOffice ? "Yes" : "No"}',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                GradientButton(
                  onPressed: () {
                    FirestoreService.updateFcmToken("");
                    auth.FirebaseAuth.instance.signOut();
                  },
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
