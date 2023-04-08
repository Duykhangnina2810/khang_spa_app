import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screen/page_c_screen.dart';

import '../../../core/router/app_router.dart';

class LayoutPageC extends StatelessWidget {
  const LayoutPageC({Key? key, required this.id}) : super(key: key);

  final String? id;

  // Định danh Route cho Screen
  static const String pathRoute = '/page-c';
  static GoRoute goRoute() {
    return GoRoute(
      path: '$pathRoute/:id',
      pageBuilder: (context, state) => AppRouter.customTransitionPage(
          state, LayoutPageC(id: state.params['id'])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageCScreen(id: id);
  }
}
