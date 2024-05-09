import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/models/user.dart';
import 'package:hawk/widgets/gradientstack.dart';

class InOfficeScreen extends StatelessWidget {
  const InOfficeScreen({super.key});

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
          title: const Text(
            "Employees In Office",
            style: TextStyle(fontSize: 22),
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
                    List<User?> users = snapshot.data!.docs
                        .map((doc) {
                          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                          if (data['in_office'] == true) {
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

                    return Column(
                      children: [
                        Text(
                          "Number of Employees In Office: ${users.length}",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ListView.builder(
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
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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
