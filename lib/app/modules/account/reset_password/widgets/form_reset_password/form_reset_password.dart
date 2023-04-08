import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../../widgets/nd_textfield_widget/nd_textfield_widget.dart';
import '../../../signin/layout_signin.dart';
import 'provider/form_reset_password_controller.dart';
import '../../../../../constants/app_ui.dart';
import '../../../../widgets/dialog/material_dialogs.dart';
import '../../../../widgets/loading/loading.dart';
import '../../../../../utils/formz/form_models/password_input.dart';
import '../../../../../utils/formz/form_models/repassword_input.dart';
import '../../../../../utils/formz/formz.dart';

class FormResetPassword extends ConsumerWidget {
  const FormResetPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(formResetPasswordProvider, (previous, next) {
      if (next.status == FormzStatus.submissionSuccess) {
        Loading(context).stop();
        Dialogs.materialDialog(
          context: context,
          lottieBuilder: Lottie.asset(AppUI.animationIconSuccess),
          title: 'CHÚC MỪNG BẠN ĐÃ THAY ĐỔI MẬT KHẨU THÀNH CÔNG',
          msg: 'Vui lòng đăng nhập để có trải nghiệm tốt nhất. Xin cảm ơn.',
          autoHide: Duration(seconds: 5),
          barrierDismissible: false,
          onClose: (value) {
            context.go(LayoutSignIn.pathRoute);
          },
        );
      }
      if (next.status == FormzStatus.submissionFailure) {
        Loading(context).stop();
        Dialogs.materialDialog(
          context: context,
          lottieBuilder: Lottie.asset(AppUI.animationIconError),
          title: 'Vấn đề trong quá trình thay đổi mật khẩu',
          msg: next.errorMessage,
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
                  'Đặt lại mật khẩu'.toUpperCase(),
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600, fontSize: 19),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Vui lòng nhập lại mật khẩu mới của bạn ở bên dưới',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),
                _PasswordInput(),
                const SizedBox(height: 12),
                _RePasswordInput(),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Align(
            child: _BtnResetPassword(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: GestureDetector(
              child: Text(
                'Đăng Nhập',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                context.go(LayoutSignIn.pathRoute);
              },
            ),
          ),
        ],
      ),
    );
    ;
  }
}

class _PasswordInput extends ConsumerWidget {
  const _PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(formResetPasswordProvider);
    return NdTextFieldWidget(
      labelText: 'Mật khẩu',
      hintText: 'Mật khẩu',
      borderRadius: 40,
      isPasswordField: true,
      onChanged: (value) {
        ref.read(formResetPasswordProvider.notifier).onPasswordChange(value);
      },
      error: state.password.invalid
          ? state.password.error!.getError(context)
          : null,
    );
  }
}

class _RePasswordInput extends ConsumerWidget {
  const _RePasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(formResetPasswordProvider);
    return NdTextFieldWidget(
      labelText: 'Nhập lại mật khẩu',
      hintText: 'Nhập lại mật khẩu',
      borderRadius: 40,
      isPasswordField: true,
      onChanged: (value) {
        ref.read(formResetPasswordProvider.notifier).onRePasswordChange(value);
      },
      error: state.rePassword.invalid
          ? state.rePassword.error!.getError(context)
          : null,
    );
  }
}

class _BtnResetPassword extends ConsumerWidget {
  const _BtnResetPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(formResetPasswordProvider);
    return GFButton(
      shape: GFButtonShape.pills,
      text: 'Xác nhận'.toUpperCase(),
      color: Theme.of(context).primaryColor,
      textStyle: GoogleFonts.montserrat(
          fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      size: 40,
      onPressed: () {
        if (state.status == FormzStatus.valid ||
            state.status == FormzStatus.submissionFailure) {
          Loading(context).start();
          ref.read(formResetPasswordProvider.notifier).onSubmit();
        }
      },
    );
  }
}
