import 'package:flutter/material.dart';
import '../widgets/forgot_password/form_forget_password.dart';
import '../../../widgets/copyright_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: const [
            FormForgotPassword(),
          ],
        ),
      ),
      bottomNavigationBar: CopyrightWidget(),
    );
  }
}
