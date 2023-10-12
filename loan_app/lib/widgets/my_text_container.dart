import 'package:flutter/material.dart';

class MyTextContainer extends StatelessWidget {
  final String title;
  const MyTextContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(title),
        ));
  }
}
