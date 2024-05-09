import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/models/user.dart';
import 'package:hawk/screens/admin/user_details_screen.dart';
import 'package:hawk/widgets/gradientstack.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientStack(
      gradients: const [
        AppGradients.screenBg,
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "User Records",
                style: TextStyle(fontSize: 22),
              ),
              Text.rich(
                TextSpan(
                  text: "Click on any to open",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<User?> users;
                    if (Auth.FirebaseAuth.instance.currentUser?.uid == "CqKy2vkkA8bF1WhKviwJoA57Ewd2") {
                      users = snapshot.data!.docs
                          .map((doc) {
                            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                            if (data['isPhotoTaken'] == true) {
                              return User(
                                uid: data['uid'],
                                name: data['name'],
                                email: data['email'],
                                status: data['status'],
                                inOffice: data['in_office'],
                                role: data['role'],
                                isPhotoTaken: data['isPhotoTaken'],
                                startDate: data['start_date'],
                                stopTime: data['stop_time'],
                                startTime: data['start_time'],
                                earlyExitDays: data['early_exit_days'],
                                employeeId: data['employee_id'],
                                lateEntryDays: data['late_entry_days'],
                                totalDays: data['total_days'],
                                workingDays: data['working_days'],
                                workingMinutes: data['working_minutes'],
                                expectedWorkHours: data['expected_work_hours'],
                                fcmtoken: data['fcm_token'],
                              );
                            }
                            return null;
                          })
                          .where((element) => element != null)
                          .toList();
                    } else {
                      users = snapshot.data!.docs
                          .map((doc) {
                            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                            if (data['isPhotoTaken'] == true && data['role'] == "employee") {
                              return User(
                                uid: data['uid'],
                                name: data['name'],
                                email: data['email'],
                                status: data['status'],
                                inOffice: data['in_office'],
                                role: data['role'],
                                isPhotoTaken: data['isPhotoTaken'],
                                startDate: data['start_date'],
                                stopTime: data['stop_time'],
                                startTime: data['start_time'],
                                earlyExitDays: data['early_exit_days'],
                                employeeId: data['employee_id'],
                                lateEntryDays: data['late_entry_days'],
                                totalDays: data['total_days'],
                                workingDays: data['working_days'],
                                workingMinutes: data['working_minutes'],
                                expectedWorkHours: data['expected_work_hours'],
                                fcmtoken: data['fcm_token'],
                              );
                            }
                            return null;
                          })
                          .where((element) => element != null)
                          .toList();
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        User? user = users[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                          child: Card(
                            color: const Color(0xFF044E6A),
                            child: ListTile(
                              title: Text(
                                user!.name,
                                style: const TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                user.email,
                                style: const TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (user.role == "manager")
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Text(
                                          "Manager",
                                          style:
                                              TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                        )),
                                  const SizedBox(width: 8), // Add some space between icons
                                  if (user.role == "employee")
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Text(
                                          "Employee",
                                          style:
                                              TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                        )),
                                  // Container(
                                  //   padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.white,
                                  //     borderRadius: BorderRadius.circular(12),
                                  //   ),
                                  //   //TODO: Colors can be added for the percentage maybe
                                  //   child: Text(
                                  //     '77%', // Example percentage, replace with actual data later
                                  //     style: GoogleFonts.inter(
                                  //         fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                  //   ),
                                  // ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserDetailScreen(user: user),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
