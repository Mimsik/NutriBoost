import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05), // Dinamic padding
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(screenWidth * 0.065), // Dinamic border radius
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        height: screenHeight * 0.05, // Dinamic height
      ),
    );
  }
}
