import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  static String? fcmToken;

  static Future<void> initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
    fcmToken = await messaging.getToken();
    print(fcmToken);
  }
}
