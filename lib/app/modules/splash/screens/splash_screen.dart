import 'dart:async';

import '../../../constants/app_ui.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  double fade = 0;

  _SplashScreenState() {
    _timer = new Timer(const Duration(seconds: 1), () {
      setState(() {
        fade = 1;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Image.asset(
          AppUI.logoSplash,
        ),
      ),
    );
  }
}
