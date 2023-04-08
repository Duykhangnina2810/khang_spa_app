import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:go_router/go_router.dart';
import '../main/layout_main.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(error),
              const SizedBox(
                height: 10,
              ),
              GFButton(
                text: 'Back',
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                onPressed: () {
                  context.go(LayoutMain.pathRoute);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
