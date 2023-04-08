import 'package:app_example/app/modules/main/home/layout_home.dart';
import 'package:app_example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_navbar/tab_item.dart';
import 'favorite/screen/favorite_screen.dart';
import 'pagea/layout_page_a.dart';
// import 'pageb/layout_page_b.dart';
import 'pagec/layout_page_c.dart';

import '../../core/router/app_router.dart';
import '../account/profile/layout_profile.dart';
import '../widgets/layout_bottom_navbar/layout_bottom_navbar.dart';

// Home
class LayoutMain extends StatelessWidget {
  LayoutMain({super.key});

  // Định danh Route cho Screen
  static const String pathRoute = '/';
  static GoRoute goRoute() {
    return GoRoute(
      path: pathRoute,
      pageBuilder: (context, state) => AppRouter.customTransitionPage(state, LayoutMain()),
    );
  }

  List<Widget> listScreens = [
    const LayoutHome(),
    const LayoutPageA(),
    const FavoriteScreen(),
    const LayoutPageC(
      id: '',
    ),
    const LayoutProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    List<TabItem> items = [
      TabItem(
        icon: Icons.home,
        title: context.translate.nav1.toString(),
      ),
      TabItem(
        icon: Icons.search_sharp,
        title: context.translate.nav2.toString(),
      ),
      TabItem(
        icon: Icons.favorite_border,
        title: context.translate.nav3.toString(),
      ),
      TabItem(
        icon: Icons.shopping_cart_outlined,
        title: context.translate.nav4.toString(),
      ),
      TabItem(
        icon: Icons.account_box,
        title: context.translate.nav5.toString(),
      ),
    ];
    return LayoutBottomNavbar(
      listScreens: listScreens,
      itemsTab: items,
    );
  }
}
