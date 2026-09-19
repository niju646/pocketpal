import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  const CustomSubmitButton({
    super.key,
    this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
