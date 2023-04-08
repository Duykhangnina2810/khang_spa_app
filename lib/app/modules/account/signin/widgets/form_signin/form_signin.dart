import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';

import '../../../../main/layout_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../../widgets/nd_textfield_widget/nd_textfield_widget.dart';
import '../../../forgot_password/layout_forgot_password.dart';
import '../../../signup/layout_signup.dart';
import '../../../widgets/button_icon_social.dart';
import '../facebook_signin/facebook_signin_button.dart';
import '../../../../../utils/formz/form_models/email_input.dart';
import '../../../../../utils/formz/form_models/password_input.dart';
import '../../../../widgets/dialog/material_dialogs.dart';

import '../../../../../constants/app_ui.dart';
import '../../../../../utils/formz/formz.dart';
import '../../../../widgets/loading/loading.dart';
import '../google_signin/google_signin_button.dart';
import 'provider/signin_controller.dart';

class FormSignIn extends ConsumerWidget {
  const FormSignIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(signInProvider, (previous, next) {
      if (next.status == FormzStatus.submissionInProgress) {
        Loading(context).start();
      }
      if (next.status == FormzStatus.submissionSuccess) {
        Loading(context).stop();
      }
      if (next.status == FormzStatus.submissionFailure) {
        Loading(context).stop();
        Dialogs.materialDialog(
          context: context,
          lottieBuilder: Lottie.asset(AppUI.animationIconError),
          title: next.errorMessage,
          barrierDismissible: false,
          autoHide: Duration(seconds: 3),
        );
      }
    });

    return Container(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width - 32,
            padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                Text(
                  'đăng nhập'.toUpperCase(),
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600, fontSize: 19),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Vui lòng nhập vào thông tin bên dưới',
                  style: GoogleFonts.montserrat(fontSize: 14),
                ),
                const SizedBox(height: 30),
                _EmailInput(),
                const SizedBox(height: 12),
                _PasswordInput(),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: GestureDetector(
                    child: Text(
                      'Quên mật khẩu ?',
                      style: GoogleFonts.montserrat(fontSize: 14),
                    ),
                    onTap: () {
                      context.go(LayoutForgotPassword.pathRoute);
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            child: _BtnLogin(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bạn chưa có tài khoản ?',
                  style: GoogleFonts.montserrat(),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Text(
                    'Đăng ký',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    context.go(LayoutSignUp.pathRoute);
                  },
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FacebookSignInButton(),
                const SizedBox(width: 12),
                GoogleSigninButton(),
              ],
            ),
          ),
          _BtnSkipSignIn(),
        ],
      ),
    );
  }
}

class _EmailInput extends ConsumerWidget {
  const _EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInProvider);
    return NdTextFieldWidget(
      labelText: 'Email',
      hintText: 'Email',
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderRadius: 40,
      onChanged: (value) {
        ref.read(signInProvider.notifier).onEmailChange(value);
      },
      error: state.email.invalid ? state.email.error!.getError(context) : null,
    );
  }
}

class _PasswordInput extends ConsumerWidget {
  const _PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInProvider);
    return NdTextFieldWidget(
      labelText: 'Mật khẩu',
      hintText: 'Mật khẩu',
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderRadius: 40,
      isPasswordField: true,
      onChanged: (value) {
        ref.read(signInProvider.notifier).onPasswordChange(value);
      },
      error: state.password.invalid
          ? state.password.error!.getError(context)
          : null,
    );
  }
}

class _BtnLogin extends ConsumerWidget {
  const _BtnLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInProvider);
    return GFButton(
      shape: GFButtonShape.pills,
      text: 'đăng nhập'.toUpperCase(),
      color: Theme.of(context).primaryColor,
      textStyle: GoogleFonts.montserrat(
          fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      size: 40,
      onPressed: () {
        if (state.status == FormzStatus.valid ||
            state.status == FormzStatus.submissionFailure) {
          ref.read(signInProvider.notifier).signIn();
        }
      },
    );
  }
}

class _BtnLoginApple extends StatelessWidget {
  const _BtnLoginApple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonIconSocial(
      iconPath: AppUI.icApple,
      onTap: () {
        print('login Apple');
      },
    );
  }
}

class _BtnSkipSignIn extends ConsumerWidget {
  const _BtnSkipSignIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: GestureDetector(
        onTap: () {
          context.go(LayoutMain.pathRoute);
        },
        child: Text(
          'Bỏ qua Đăng Nhập',
          style: GoogleFonts.montserrat(
              fontSize: 15,
              textStyle: const TextStyle(decoration: TextDecoration.underline)),
        ),
      ),
    );
  }
}
