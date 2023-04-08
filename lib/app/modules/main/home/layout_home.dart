import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screen/home_screen.dart';
import '../../../core/router/app_router.dart';

class LayoutHome extends StatelessWidget {
  const LayoutHome({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/home';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) =>
          AppRouter.customTransitionPage(state, LayoutHome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
