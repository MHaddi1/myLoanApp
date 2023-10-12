import 'package:flutter/material.dart';

class DOBInputField extends StatefulWidget {
  final TextEditingController controller;
  final String fieldLabelText;
  final ValueChanged<DateTime>? onChanged;

  const DOBInputField({
    Key? key,
    required this.controller,
    required this.fieldLabelText,
    this.onChanged,
  }) : super(key: key);

  @override
  _DOBInputFieldState createState() => _DOBInputFieldState();
}

class _DOBInputFieldState extends State<DOBInputField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateText);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateText);
    super.dispose();
  }

  void _updateText() {
    final text = widget.controller.text;
    final cleanedText = _cleanText(text);

    if (text != cleanedText) {
      widget.controller.value = TextEditingValue(
        text: cleanedText,
        selection: TextSelection.collapsed(offset: cleanedText.length),
      );
    }
  }

  String _cleanText(String text) {
    text = text.replaceAll(RegExp(r'[^0-9/]'), ''); // Remove non-numeric and non-slash characters

    if (text.length == 1 && int.tryParse(text) != null) {
      // If the user enters a single digit, auto-add '0' before it
      return '0$text/';
    } else if (text.length == 2 && int.tryParse(text) != null && !text.endsWith('/')) {
      // If the user enters two digits and they don't end with '/', auto-add '/'
      return '$text/';
    } else if (text.length == 3 && text.endsWith('/')) {
      // If the user enters three characters ending with '/', auto-remove the last character
      return text.substring(0, 2);
    } else if (text.length == 4 && int.tryParse(text.substring(3)) != null) {
      // If the user enters four digits for the year, auto-add '/'
      return '${text.substring(0, 2)}/${text.substring(2)}/';
    } else if (text.length == 5 && !text.endsWith('/')) {
      // If the user enters five characters and they don't end with '/', auto-add '/'
      return '${text.substring(0, 2)}/${text.substring(2)}/';
    } else if (text.length > 10) {
      // Limit the total length to 10 characters (DD/MM/YYYY)
      return text.substring(0, 10);
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: widget.fieldLabelText,
      ),
      onChanged: (text) {
        final cleanedText = _cleanText(text);
        if (widget.onChanged != null) {
          widget.onChanged!(DateTime.tryParse(cleanedText) ?? DateTime(2000, 12, 12));
        }
      },
    );
  }
}
