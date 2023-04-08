import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import 'screen/notification_screen.dart';

class LayoutNotification extends StatelessWidget {
  const LayoutNotification({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/notification';
  // static const String pathRoute = '/';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) => AppRouter.customTransitionPage(state, const LayoutNotification()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const NotificationScreen();
  }
}
