import 'package:flutter/material.dart';

class StackedLabelTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final bool readOnly;

  const StackedLabelTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.black,
            // fontSize: 12.0,
            // fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
            height: 36,
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              readOnly: readOnly,
            ),
          ),
        ),
      ],
    );
  }
}
