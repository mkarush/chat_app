import 'package:flutter/material.dart';
import 'package:import_chat_app/authentication/styling/styling.dart';

class ElevatedButtonField extends StatelessWidget {
  const ElevatedButtonField({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final String? text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(shape: elevatedStyle),
            child: Text(
              '$text',
              style: buttonTextStyle,
            )),
      ),
    );
  }
}
