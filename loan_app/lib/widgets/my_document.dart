import 'package:flutter/material.dart';
import 'package:loan_app/consts/colors.dart';

class MyDoumnent extends StatelessWidget {
  final String title;
  final IconData ficonData;
  final String siconData;
  const MyDoumnent(
      {super.key,
      required this.title,
      required this.ficonData,
      required this.siconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          color: back,
        ),
        child: ListTile(
            leading: Icon(
              ficonData,
              color: Colors.black,
            ),
            title: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
            trailing: Image.asset(siconData)),
      ),
    );
  }
}
