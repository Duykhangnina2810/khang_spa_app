import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import 'screen/forgot_password_screen.dart';

class LayoutForgotPassword extends StatelessWidget {
  const LayoutForgotPassword({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/forgot-password';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) =>
          AppRouter.customTransitionPage(state, const LayoutForgotPassword()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordScreen();
  }
}
