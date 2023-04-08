import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import 'screen/favorite_screen.dart';

class LayoutFavorite extends StatelessWidget {
  const LayoutFavorite({Key? key}) : super(key: key);

  // Định danh Route cho Screen
  static const String pathRoute = '/favorite';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) => AppRouter.customTransitionPage(state, const LayoutFavorite()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const FavoriteScreen();
  }
}
