import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../constants/app_ui.dart';
import '../../../widgets/button_icon_social.dart';
import 'provider/facebook_signin_controller.dart';

class FacebookSignInButton extends ConsumerWidget {
  const FacebookSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final facebookSigninState = ref.watch(facebookSignInProvider);

    return ButtonIconSocial(
      iconPath: AppUI.icFacebook,
      isLoading:
          (facebookSigninState == FacebookSignInState.loading) ? true : false,
      onTap: () {
        if (facebookSigninState != FacebookSignInState.loading) {
          ref.read(facebookSignInProvider.notifier).signIn();
        }
      },
    );
  }
}
