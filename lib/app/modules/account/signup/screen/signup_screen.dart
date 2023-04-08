import 'package:flutter/material.dart';
import '../../../widgets/copyright_widget.dart';
import '../widgets/form_signup/form_signup.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: const [
            FormSignUp(),
          ],
        ),
      ),
      bottomNavigationBar: const CopyrightWidget(),
    );
  }
}
