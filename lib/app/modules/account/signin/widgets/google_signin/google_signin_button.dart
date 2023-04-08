import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/app_ui.dart';
import '../../../widgets/button_icon_social.dart';
import 'provider/google_signin_controller.dart';

class GoogleSigninButton extends ConsumerWidget {
  const GoogleSigninButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleSigninState = ref.watch(googleSignInProvider);

    return ButtonIconSocial(
      iconPath: AppUI.icGoogle,
      isLoading:
          (googleSigninState == GoogleSignInState.loading) ? true : false,
      onTap: () {
        if (googleSigninState != GoogleSignInState.loading) {
          ref.read(googleSignInProvider.notifier).signIn();
        }
      },
    );
  }
}
