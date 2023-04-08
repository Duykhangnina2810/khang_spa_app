import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/app_router.dart';
import 'screens/splash_screen.dart';

class LayoutSplash extends StatelessWidget {
  const LayoutSplash({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/splash';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) =>
          AppRouter.customTransitionPage(state, const LayoutSplash()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
