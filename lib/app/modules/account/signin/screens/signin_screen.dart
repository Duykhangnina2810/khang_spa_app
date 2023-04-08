import 'package:flutter/material.dart';
import '../../../widgets/copyright_widget.dart';
import '../widgets/form_signin/form_signin.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormSignIn(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CopyrightWidget(),
    );
  }
}
