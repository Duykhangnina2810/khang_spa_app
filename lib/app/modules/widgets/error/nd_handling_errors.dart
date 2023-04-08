import 'package:flutter/material.dart';

class NdHandlingErrors extends StatelessWidget {
  const NdHandlingErrors({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      color: Colors.red,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.zero,
    );
  }
}
