import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import 'screen/reset_password_screen.dart';

class LayoutResetPassword extends StatelessWidget {
  const LayoutResetPassword({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/reset-password';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) =>
          AppRouter.customTransitionPage(state, const LayoutResetPassword()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResetPasswordScreen();
  }
}
