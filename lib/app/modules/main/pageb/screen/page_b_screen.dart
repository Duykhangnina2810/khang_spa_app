import 'package:flutter/material.dart';

class PageBScreen extends StatelessWidget {
  PageBScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yêu thích'),
      ),
      body: Center(
        child: Text('Yêu thích'),
      ),
    );
  }
}
