import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import 'screen/profile_screen.dart';

class LayoutProfile extends StatelessWidget {
  const LayoutProfile({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/profile';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) =>
            AppRouter.customTransitionPage(state, const LayoutProfile()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScreen();
  }
}
