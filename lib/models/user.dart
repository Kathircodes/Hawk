import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String status;
  final bool inOffice;
  final bool isPhotoTaken;
  final String role;
  final String startDate;
  final String startTime;
  final String stopTime;
  final int earlyExitDays;
  final String employeeId;
  final int lateEntryDays;
  final int totalDays;
  final int workingDays;
  final int workingMinutes;
  final int expectedWorkHours;
  final String fcmtoken;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.status,
    required this.inOffice,
    required this.isPhotoTaken,
    required this.role,
    required this.startDate,
    required this.startTime,
    required this.stopTime,
    required this.earlyExitDays,
    required this.employeeId,
    required this.lateEntryDays,
    required this.totalDays,
    required this.workingDays,
    required this.workingMinutes,
    required this.expectedWorkHours,
    required this.fcmtoken,
  });

  factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return User(
      uid: snapshot.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      status: data['status'] ?? '',
      inOffice: data['inOffice'] ?? false,
      isPhotoTaken: data['isPhotoTaken'] ?? false,
      role: data['role'] ?? '',
      startDate: data['start_date'] ?? '',
      startTime: data['start_time'] ?? '',
      stopTime: data['stop_time'] ?? '',
      earlyExitDays: data['early_exit_days'] ?? 0,
      employeeId: data['employee_id'] ?? '',
      lateEntryDays: data['late_entry_days'] ?? 0,
      totalDays: data['total_days'] ?? 0,
      workingDays: data['working_days'] ?? 0,
      workingMinutes: data['working_minutes'] ?? 0,
      expectedWorkHours: data['expected_work_hours'] ?? 0,
      fcmtoken: data['fcm_token'] ?? '',
    );
  }

  factory User.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
  Map<String, dynamic> data = snapshot.data()!;
  return User(
    uid: snapshot.id,
    name: data['name'] ?? '',
    email: data['email'] ?? '',
    status: data['status'] ?? '',
    inOffice: data['inOffice'] ?? false,
    isPhotoTaken: data['isPhotoTaken'] ?? false,
    role: data['role'] ?? '',
    startDate: data['start_date'] ?? '',
    startTime: data['start_time'] ?? '',
    stopTime: data['stop_time'] ?? '',
    earlyExitDays: data['early_exit_days'] ?? 0,
    employeeId: data['employee_id'] ?? '',
    lateEntryDays: data['late_entry_days'] ?? 0,
    totalDays: data['total_days'] ?? 0,
    workingDays: data['working_days'] ?? 0,
    workingMinutes: data['working_minutes'] ?? 0,
    expectedWorkHours: data['expected_work_hours'] ?? 0,
    fcmtoken: data['fcm_token'] ?? '',
  );
}
}
