import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import 'screen/page_a_screen.dart';

class LayoutPageA extends StatelessWidget {
  const LayoutPageA({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/page-a';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) =>
          AppRouter.customTransitionPage(state, LayoutPageA()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageAScreen();
  }
}
