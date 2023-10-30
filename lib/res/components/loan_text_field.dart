import 'package:flutter/material.dart';
import 'package:main_loan_app/res/colors/color.dart';

class LoanTextField extends StatelessWidget {
  final TextEditingController myController;
  final String hintText;
  final String? labelText; // Optional label text
  final bool obscureText;
  final IconData? suffixIconData;
  final Function()? onPressed;
  final Function()? onSuffixIconTap;
  final String? Function(String?)? validate;
  final int? minLength; // Minimum allowed length for the username
  final int? maxLength;
  final String? msg;
  final TextInputType textType;
  final Function(String?)? check;
  final String? errorMessage;
  final Function(Focus)? focus;
  final AutovalidateMode? autovalidateMode;
  final int? maxLines;

  const LoanTextField(
      {super.key,
      required this.myController,
      required this.hintText,
      this.labelText, // Make labelText optional
      this.obscureText = false,
      this.onSuffixIconTap,
      this.suffixIconData,
      this.onPressed,
      this.validate,
      this.minLength,
      this.maxLength,
      required this.textType,
      this.msg,
      this.check,
      this.errorMessage,
      this.focus,
      this.autovalidateMode,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      maxLength: maxLength,
      autovalidateMode: autovalidateMode,
      onChanged: check,
      keyboardType: textType,
      validator: validate,
      onTap: onPressed,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      controller: myController,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorText: errorMessage,
        labelText: labelText, // Optional label text
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColor.feildColor), // Assuming 'feildColor' is defined
        ),
        fillColor: AppColor.feildColor,
        filled: true,
        hintStyle: const TextStyle(color: Colors.black),
        suffixIcon: suffixIconData != null
            ? IconButton(
                onPressed: onSuffixIconTap,
                icon: Icon(
                  suffixIconData,
                  color: AppColor.textGrey,
                ))
            : null, // Display icon if provided, null otherwise
      ),
    );
  }
}
