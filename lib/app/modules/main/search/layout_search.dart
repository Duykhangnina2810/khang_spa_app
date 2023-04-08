import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import 'screen/search_screen.dart';

class LayoutSearch extends StatelessWidget {
  const LayoutSearch({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/search';
  // static const String pathRoute = '/';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) => AppRouter.customTransitionPage(state, const LayoutSearch()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SearchScreen();
  }
}
