import 'package:app_example/app/modules/main/list_service/screen/list_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';

class LayoutListService extends StatelessWidget {
  const LayoutListService({Key? key}) : super(key: key);
  // Định danh Route cho Screen
  static const String pathRoute = '/list-service';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) => AppRouter.customTransitionPage(state, const LayoutListService()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ListServiceScreen();
  }
}
