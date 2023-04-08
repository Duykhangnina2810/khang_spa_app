import 'package:flutter/material.dart';
class PageAScreen extends StatelessWidget {
  const PageAScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cửa hàng'),),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(child: Text('Cửa hàng'),),
      ),
    );
  }
}
