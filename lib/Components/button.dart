import 'package:flutter/material.dart';
import 'package:flutter_app/Theme/app_padding.dart';

class Button extends StatefulWidget {
  final VoidCallback onPressedButton;
  final String label;

  const Button({super.key, required this.label, required this.onPressedButton});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.medium),
      child: ElevatedButton(
        onPressed: widget.onPressedButton,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Borda quadrada
          ),
        ),
        child: Text(widget.label),
      ),
    );
  }
}
