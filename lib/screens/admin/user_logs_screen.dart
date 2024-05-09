import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hawk/appcolors.dart';
import 'package:hawk/models/attendance.dart';
import 'package:hawk/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/widgets/gradientstack.dart';

class UserLogsScreen extends StatelessWidget {
  final User user;
  const UserLogsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GradientStack(
      gradients: const [
        AppGradients.screenBg,
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('attendance_records').doc(user.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
              return const Center(
                child: Text(
                  'No attendance records found',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            }

            List<dynamic> attendance = snapshot.data!.get('attendance') ?? [];
            if (attendance.isEmpty) {
              return const Center(
                child: Text(
                  'No attendance records found',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            }

            List<AttendanceRecord> records = attendance.map((record) {
              return AttendanceRecord(
                lateEntry: record['late_entry'],
                earlyExit: record['early_exit'],
                timeIn: record['time_in'],
                timeOut: record['time_out'],
              );
            }).toList();

            records = records.reversed.toList();

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  AttendanceRecord record = records[index];
                  return Card(
                    color: AppColors.chipBlue,
                    elevation: 0,
                    child: ListTile(
                      title: Text(
                        'Time In: ${record.timeIn}',
                        style: GoogleFonts.inter(
                            color: record.lateEntry ? Colors.red : Colors.green,
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Time Out: ${record.timeOut ?? 'Not Signed Out'}',
                        style: GoogleFonts.inter(
                            color: record.earlyExit ? Colors.red : Colors.green,
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(
                          record.earlyExit ? 'Early Exit' : '',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          record.lateEntry ? 'Late Entry' : '',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ]),
                      onTap: () {
                        // Handle tap
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
