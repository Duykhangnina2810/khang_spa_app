import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../bottom_navbar/chip_style.dart';
import '../bottom_navbar/src/bottom_bar_inspired_outside.dart';
import '../bottom_navbar/tab_item.dart';
import '../bottom_navbar/widgets/inspired/inspired.dart';
import 'provider/bottom_navbar_controller.dart';

class LayoutBottomNavbar extends StatelessWidget {
  const LayoutBottomNavbar({Key? key, required this.listScreens, required this.itemsTab}) : super(key: key);

  final List<Widget> listScreens;
  final List<TabItem> itemsTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(bottomNavBarProvider);
          return listScreens[state.visit];
        },
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        final state = ref.watch(bottomNavBarProvider);
        final bottomBarController = ref.read(bottomNavBarProvider.notifier);
        return BottomBarInspiredOutside(
          elevation: 0,
          items: itemsTab,
          backgroundColor: Colors.green,
          color: Colors.white,
          colorSelected: Colors.white,
          indexSelected: state.visit,
          itemStyle: ItemStyle.circle,
          onTap: (int index) {
            bottomBarController.changeScreen(indexScreen: index);
          },
          chipStyle: const ChipStyle(
            isHexagon: false,
            convexBridge: false,
            color: Colors.white,
            background: Colors.green,
          ),
        );
      },),
    );
  }
}
