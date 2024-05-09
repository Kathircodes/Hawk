import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hawk/appconsts.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/services/auth_service.dart';
import 'package:hawk/services/firestore_service.dart';
import 'package:hawk/services/message_service.dart';
import 'package:hawk/widgets/gradientbutton.dart';
import 'package:hawk/widgets/gradientstack.dart';
import 'package:hawk/screens/signup_screen.dart';
import 'package:hawk/widgets/textfield.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientStack(
      gradients: const [AppGradients.screenBg],
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConsts.marginX),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/login.png',
                        width: 500, // Specify your desired width
                        height: 420, // Specify your desired height
                      ),
                      CustomTextField(
                        controller: emailController,
                        labelText: "Email ID",
                        hintText: "Enter your email id",
                        prefixIcon: Icons.email,
                        prefixIconColor: Colors.white,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.toLowerCase().endsWith('@gmail.com')) {
                            return 'Please enter a valid email ending with @gmail.com';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: passController,
                        labelText: "Password",
                        hintText: "Enter your password",
                        prefixIcon: Icons.password,
                        prefixIconColor: Colors.white,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      GradientButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await AuthService.signInUser(
                              emailController.text,
                              passController.text,
                              context,
                            );
                            print("Updating");
                            print(FirebaseMessagingService.fcmToken);
                            FirestoreService.updateFcmToken(FirebaseMessagingService.fcmToken);
                            // passController.clear();
                            // emailController.clear();
                          }
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: "New employee? ",
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign up here!',
                              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
