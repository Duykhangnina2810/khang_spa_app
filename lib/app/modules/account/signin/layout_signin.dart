import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import 'screens/signin_screen.dart';
import 'package:flutter/material.dart';

class LayoutSignIn extends StatelessWidget {
  const LayoutSignIn({Key? key}) : super(key: key);


  // Định danh Route cho Screen
  static const String pathRoute = '/signin';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) =>
          AppRouter.customTransitionPage(state, const LayoutSignIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SignInScreen();
  }
}
