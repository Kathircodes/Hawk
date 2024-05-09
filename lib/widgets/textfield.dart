import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom text field widget
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final Color prefixIconColor;
  final bool isPassword;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.prefixIconColor,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 20),
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: prefixIconColor),
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 20),
          errorStyle: const TextStyle(fontSize: 18),
          labelStyle: const TextStyle(fontSize: 20, color: Colors.white54),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.green),
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
