import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hawk/services/message_service.dart';
// import 'package:intl/intl.dart';

class FirestoreService {
  static User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    User? user = getUser();
    if (user != null) {
      return FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    }
    throw Exception('No authenticated user found');
  }

  static saveUser(String name, email, uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'uid': uid,
        'email': email,
        'name': name,
        'status': "waiting",
        'in_office': false,
        'role': "employee",
        'fcm_token': FirebaseMessagingService.fcmToken,
      },
    );
    await FirebaseFirestore.instance.collection('requests').doc(uid).set(
      {
        'uid': uid,
        'email': email,
        'name': name,
        'status': "waiting",
        'in_office': false,
        'role': "employee",
      },
    );
  }

  static Future<List<String>> getStatusandRole() async {
    var user = await getUserData();
    if (user.exists) {
      // print(user.data()!['status']);
      return [user.data()!['status'], user.data()!['role']];
    } else {
      throw Exception('User document not found');
    }
  }

  static deleteRequest(String uid) async {
    try {
      await FirebaseFirestore.instance.collection('requests').doc(uid).delete();
      print('Document with UID $uid deleted successfully');
    } catch (e) {
      throw Exception('Error deleting document: $e');
    }
  }

  static updateAcceptedUser(String uid, String selectedRole, String startDate, String startTime, String stopTime,
      int expectedhours, bool photo) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update(
      {
        'status': 'accepted',
        'role': selectedRole.toLowerCase(),
        'start_date': startDate,
        'start_time': startTime,
        'stop_time': stopTime,
        'isPhotoTaken': photo,
        'expected_work_hours': expectedhours,
      },
    );
  }

  static updateRejectedUser(String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update(
      {
        'status': 'rejected',
      },
    );
  }

  static Future<void> updateFcmToken(String? fcmToken) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'fcm_token': fcmToken,
        });
      } catch (e) {
        // Handle update errors
        print(e.toString());
      }
    }
  }
}
