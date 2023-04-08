import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import 'screen/service_detail_screen.dart';

class LayoutServiceDetail extends StatelessWidget {
  const LayoutServiceDetail({Key? key}) : super(key: key);
  // Định danh Route cho Screen
  static const String pathRoute = '/service-detail';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) => AppRouter.customTransitionPage(state, const LayoutServiceDetail()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ServiceDetailScreen();
  }
}
