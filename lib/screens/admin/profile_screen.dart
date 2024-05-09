import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hawk/appcolors.dart';
import 'package:hawk/appconsts.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/services/firestore_service.dart';
import 'package:hawk/widgets/gradientbutton.dart';
import 'package:hawk/widgets/gradientstack.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdProfileScreen extends StatefulWidget {
  const AdProfileScreen({super.key});

  @override
  State<AdProfileScreen> createState() => _AdProfileScreenState();
}

class _AdProfileScreenState extends State<AdProfileScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = FirestoreService.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return GradientStack(
      gradients: const [AppGradients.screenBg],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConsts.marginX),
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: _userDataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      final userData = snapshot.data!.data()!;
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.96,
                        height: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          color: AppColors.chipBlue, // Change this to your desired color
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${userData['name']}',
                                style: const TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Email ID: ${userData['email']}',
                                style: const TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Employee Id: ${userData['employeeId']}',
                                style: const TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Role: ${userData['role']}',
                                style: const TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConsts.marginX),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradientButton(
                      onPressed: () {
                        FirestoreService.updateFcmToken("");
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
