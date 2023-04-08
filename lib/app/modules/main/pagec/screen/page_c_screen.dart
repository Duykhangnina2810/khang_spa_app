import 'package:flutter/material.dart';

class PageCScreen extends StatelessWidget {
  const PageCScreen({Key? key, required this.id}) : super(key: key);

  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Center(child: Text('Shopping Cart'),),
    );
  }
}
