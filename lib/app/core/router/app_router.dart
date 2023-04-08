import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../modules/onboarding/layout_onboarding.dart';
import '../../modules/account/reset_password/layout_reset_password.dart';
import '../../modules/account/verification_code/layout_verification_code.dart';
import '../../modules/account/forgot_password/layout_forgot_password.dart';
import '../../modules/splash/layout_splash.dart';
import '../../modules/account/signup/layout_signup.dart';
import '../../modules/account/signin/layout_signin.dart';

import '../../modules/error/error_screen.dart';
import '../../modules/main/layout_main.dart';

class AppRouter {
  static List<RouteBase> listRouteBase = [
    LayoutSplash.goRoute(),
    LayoutOnboarding.goRoute(),
    LayoutMain.goRoute(),
    LayoutSignIn.goRoute(),
    LayoutSignUp.goRoute(),
    LayoutForgotPassword.goRoute(),
    LayoutVerificationCode.goRoute(),
    LayoutResetPassword.goRoute(),
  ];

  static GoRouter createGoRouter() {
    return GoRouter(
      // initialLocation: LayoutServiceDetail.pathRoute,
      routes: listRouteBase,
      errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),
    );
  }

  static addGoRoute({required List<GoRoute>? newGoRoutes}) {
    if (newGoRoutes != null) {
      for (var newGoRoute in newGoRoutes) {
        if (!listRouteBase.contains(newGoRoute)) {
          listRouteBase.add(newGoRoute);
        }
      }
    }
  }

  static CustomTransitionPage customTransitionPage(GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Change the opacity of the screen using a Curve based on the the animation's
        // value
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}
