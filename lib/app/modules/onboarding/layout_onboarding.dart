import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import 'screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class LayoutOnboarding extends StatelessWidget {
  const LayoutOnboarding({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/onboarding';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) =>
          AppRouter.customTransitionPage(state, const LayoutOnboarding()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const OnboardingScreen();
  }
}
