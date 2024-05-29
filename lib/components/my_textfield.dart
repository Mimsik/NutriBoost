import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20), // Adjust the padding for wider text fields
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          color: Colors.white, // User entered text color
          fontFamily: 'JosefinSans',
        ),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          fillColor: Color.fromARGB(130, 0, 0, 0),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontFamily: 'JosefinSans',
          ),
        ),
      ),
    );
  }
}
