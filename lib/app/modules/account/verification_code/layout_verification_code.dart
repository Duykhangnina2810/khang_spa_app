import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import 'screen/verification_code_screen.dart';

class LayoutVerificationCode extends StatelessWidget {
  const LayoutVerificationCode({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/verification-code-forgot-password';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) =>
          AppRouter.customTransitionPage(state, const LayoutVerificationCode()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VerificationCodeScreen();
  }
}
