// import 'package:flutter/material.dart';

// class DropDownLoan extends StatelessWidget {
//   final String? selectedValue;
//   final Function(String) onChanged;

//   const DropDownLoan(
//       {Key? key, required this.selectedValue, required this.onChanged})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: selectedValue,
//       onChanged: onChanged(selectedValue.toString()),
//       items: <String>['Option1', 'Option2', 'Option3'].map((String val) {
//         return DropdownMenuItem<String>(
//           value: val,
//           child: Text(val),
//         );
//       }).toList(),
//     );
//   }
// }
