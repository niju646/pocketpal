import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String prefix;
  final String hinttext;
  const CustomTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.prefix,
    required this.hinttext,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixText: prefix,
        hintText: hinttext,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
