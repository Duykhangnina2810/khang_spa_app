import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import 'screen/page_b_screen.dart';

class LayoutPageB extends StatelessWidget {
  const LayoutPageB({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/page-b';
  static GoRoute goRoute() {
    return GoRoute(
        path: pathRoute,
        pageBuilder: (context, state) =>
            AppRouter.customTransitionPage(state, LayoutPageB()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageBScreen();
  }
}
