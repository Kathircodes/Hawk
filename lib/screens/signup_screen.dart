import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hawk/appconsts.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/services/auth_service.dart';
import 'package:hawk/services/snack.dart';
import 'package:hawk/widgets/gradientbutton.dart';
import 'package:hawk/widgets/gradientstack.dart';
import 'package:hawk/widgets/textfield.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController(); // Added
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/login.png',
                      width: 380, // Specify your desired width
                      height: 350, // Specify your desired height
                    ),
                    CustomTextField(
                      controller: nameController,
                      labelText: "Full Name",
                      hintText: "Enter your full name",
                      prefixIcon: Icons.person,
                      prefixIconColor: Colors.white,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        if (value.length <= 3) {
                          return 'Please enter full name';
                        }
                        return null;
                      },
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
                        if (value.length < 6 || value.length > 20) {
                          return 'Password must be 6-20 characters long';
                        }
                        if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                          return 'at least one uppercase letter';
                        }
                        if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                          return 'at least one lowercase letter';
                        }
                        if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                          return 'at least one number';
                        }
                        return null; // No error
                      },
                    ),
                    CustomTextField(
                      controller: confirmPassController,
                      labelText: "Confirm Password",
                      hintText: "Enter your password again",
                      prefixIcon: Icons.password,
                      prefixIconColor: Colors.white,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    GradientButton(
                      onPressed: () {
                        // Check if passwords match
                        if (passController.text != confirmPassController.text) {
                          Snack("Error", "Passwords do not match!", ContentType.failure, context);
                          return;
                        }

                        // Navigate to the SignUpScreen
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          AuthService.signUpUser(
                            emailController.text,
                            passController.text,
                            nameController.text,
                            context,
                          );
                        }
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Log in here!',
                            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
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
        ),
      ),
    );
  }
}
