import 'package:flutter/material.dart';
import 'package:main_loan_app/res/colors/color.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const MyButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
            color: AppColor.mainColor,
            borderRadius: BorderRadius.circular(12.0)),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
