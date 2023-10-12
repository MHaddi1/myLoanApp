import 'package:flutter/material.dart';
import 'package:loan_app/consts/colors.dart';

class MyTextFields extends StatelessWidget {
  final TextEditingController myController;
  final String hintText;
  final String? labelText; // Optional label text
  final bool obscureText;
  final IconData? suffixIconData; // Icon to display on the right side

  const MyTextFields({
    Key? key,
    required this.myController,
    required this.hintText,
    this.labelText, // Make labelText optional
    required this.obscureText,
    this.suffixIconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText, // Optional label text
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: feildColor), // Assuming 'feildColor' is defined
        ),
        fillColor: feildColor,
        filled: true,
        hintStyle: const TextStyle(color: Colors.black),
        suffixIcon: suffixIconData != null
            ? Icon(
                suffixIconData,
                color: textGrey,
              )
            : null, // Display icon if provided, null otherwise
      ),
    );
  }
}
