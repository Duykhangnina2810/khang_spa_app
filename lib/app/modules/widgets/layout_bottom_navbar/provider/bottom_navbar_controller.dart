import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'bottom_navbar_state.dart';

final bottomNavBarProvider =
    StateNotifierProvider<BottomNavBarController, BottomNavBarState>(
        (ref) => BottomNavBarController());

class BottomNavBarController extends StateNotifier<BottomNavBarState> {
  BottomNavBarController() : super(BottomNavBarState());

  changeScreen({required int indexScreen}) {
    state = state.copyWith(visit: indexScreen);
  }
}
