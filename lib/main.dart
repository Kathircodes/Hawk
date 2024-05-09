import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hawk/apptheme.dart';
import 'package:hawk/screens/auth_screen.dart';
import 'package:hawk/services/message_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessagingService.initialize();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // await messaging.requestPermission();
  // String? token = await messaging.getToken();
  // print('FirebaseMessaging token: $token');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
    );
  }
}
