import 'package:flutter/material.dart';
import 'package:import_chat_app/authentication/styling/styling.dart';

class TextForm extends StatelessWidget {
  const TextForm(
      {Key? key,
      required this.controller,
      required this.onChanged,
      required this.hintText,
      required this.validator,
      this.obscureText})
      : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        decoration: InputDecoration(
            focusedBorder: focusedBorderStyle,
            enabledBorder: enableBorderStyle,
            errorBorder: enableBorderStyle,
            focusedErrorBorder: focusedBorderStyle,
            labelText: hintText,
            labelStyle: labelTextStyle),
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText ?? false,
      ),
    );
  }
}
