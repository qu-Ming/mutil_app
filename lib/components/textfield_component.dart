import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({
    Key? key,
    required this.text,
    this.textInputType,
    required this.textEditingController,
    this.errorText,
    this.colorText,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;
  final String text;
  final String? errorText;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;
  final Color? colorText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 5),
      child: TextField(
        controller: textEditingController,
        keyboardType: textInputType,
        onChanged: onChanged,
        decoration: InputDecoration(
          errorText: errorText,
          border: const OutlineInputBorder(borderSide: BorderSide(width: 1)),
          disabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(width: 1)),
          // labelText: 'Email Address',
          hintText: text,
          hintStyle: TextStyle(color: colorText, fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}
