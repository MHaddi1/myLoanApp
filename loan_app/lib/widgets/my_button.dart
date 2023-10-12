import 'package:flutter/material.dart';
import 'package:loan_app/consts/colors.dart';

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
            color: mainColor, borderRadius: BorderRadius.circular(12.0)),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
