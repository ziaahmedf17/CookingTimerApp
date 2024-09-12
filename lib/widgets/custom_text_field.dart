import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.verticalLength,
  });
  final double verticalLength;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(color: Colors.grey)),
          contentPadding: EdgeInsets.symmetric(vertical: verticalLength)),
    );
  }
}
