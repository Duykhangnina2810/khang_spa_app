import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../../../utils/formz/form_models/email_input.dart';
import '../../../../widgets/nd_textfield_widget/nd_textfield_widget.dart';
import '../../../signin/layout_signin.dart';
import '../../../verification_code/layout_verification_code.dart';
import 'provider/forgot_password_controller.dart';
import '../../../../widgets/dialog/material_dialogs.dart';

import '../../../../../constants/app_ui.dart';
import '../../../../../utils/formz/formz.dart';
import '../../../../widgets/loading/loading.dart';

class FormForgotPassword extends ConsumerWidget {
  const FormForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(forgotPasswordProvider, (previous, next) {
      if (next.status == FormzStatus.submissionInProgress) {
        Loading(context).start();
      }
      if (next.status == FormzStatus.submissionSuccess) {
        Loading(context).stop();
        // kiểm tra email đã đăng ký thành công --> tiến hành xác thực email chính chủ
        context.go(LayoutVerificationCode.pathRoute);
      }
      if (next.status == FormzStatus.submissionFailure) {
        Loading(context).stop();
        Dialogs.materialDialog(
          context: context,
          lottieBuilder: Lottie.asset(AppUI.animationIconError),
          title: next.errorMessage,
          autoHide: Duration(seconds: 3),
          barrierDismissible: false,
        );
      }
    });

    return Container(
      margin: const EdgeInsets.only(top: 200),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width - 32,
            padding:
                const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
            child: Column(
              children: [
                Text(
                  'Quên mật khẩu'.toUpperCase(),
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600, fontSize: 19),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Vui lòng nhập email đã đăng ký',
                  style: GoogleFonts.montserrat(fontSize: 14),
                ),
                const SizedBox(height: 30),
                _EmailInput(),
              ],
            ),
          ),
          Align(
            child: _BtnSubmit(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Đăng Nhập',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              onTap: () {
                context.go(LayoutSignIn.pathRoute);
              },
            ),
          ),
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
    final state = ref.watch(forgotPasswordProvider);
    return NdTextFieldWidget(
      labelText: 'Email',
      hintText: 'Email',
      borderRadius: 40,
      onChanged: (value) {
        ref.read(forgotPasswordProvider.notifier).onEmailChange(value);
      },
      error: state.email.invalid ? state.email.error!.getError(context) : null,
    );
  }
}

class _BtnSubmit extends ConsumerWidget {
  const _BtnSubmit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordProvider);
    return GFButton(
      shape: GFButtonShape.pills,
      text: 'Tiếp tục'.toUpperCase(),
      color: Theme.of(context).primaryColor,
      textStyle: GoogleFonts.montserrat(
          fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      size: 40,
      onPressed: () {
        if (state.status == FormzStatus.valid ||
            state.status == FormzStatus.submissionFailure) {
          ref.read(forgotPasswordProvider.notifier).forgotPassword();
        }
      },
    );
  }
}
