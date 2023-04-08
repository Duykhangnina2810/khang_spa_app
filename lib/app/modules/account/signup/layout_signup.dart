import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import 'screen/signup_screen.dart';

class LayoutSignUp extends StatelessWidget {
  const LayoutSignUp({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/signup';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) =>
          AppRouter.customTransitionPage(state, const LayoutSignUp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SignUpScreen();
  }
}
