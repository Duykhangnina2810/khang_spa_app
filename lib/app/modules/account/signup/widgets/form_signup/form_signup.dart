import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../../../utils/formz/form_models/email_input.dart';
import '../../../../../utils/formz/form_models/password_input.dart';
import '../../../../../utils/formz/form_models/repassword_input.dart';
import '../../../../../utils/formz/form_models/text_input.dart';
import '../../../../../constants/app_ui.dart';
import '../../../../widgets/dialog/material_dialogs.dart';
import '../../../../widgets/loading/loading.dart';
import '../../../../widgets/nd_textfield_widget/nd_textfield_widget.dart';
import '../../../signin/layout_signin.dart';
import 'provider/signup_controller.dart';
import '../../../../../utils/formz/formz.dart';

class FormSignUp extends ConsumerWidget {
  const FormSignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(signUpProvider, (previous, next) {
      if (next.status == FormzStatus.submissionSuccess) {
        Loading(context).stop();
        Dialogs.materialDialog(
          context: context,
          lottieBuilder: Lottie.asset(AppUI.animationIconSuccess),
          title: 'CHÚC MỪNG BẠN ĐÃ ĐĂNG KÝ THÀNH CÔNG',
          msg: 'Vui lòng đăng nhập để có trải nghiệm tốt nhất. Xin cảm ơn.',
          autoHide: Duration(seconds: 3),
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
          title: 'Đăng ký không thành công.',
          msg: next.errorMessage,
          autoHide: Duration(seconds: 3),
          barrierDismissible: false,
        );
      }
    });

    return Container(
      margin: const EdgeInsets.only(top: 100),
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
                  'đăng ký'.toUpperCase(),
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
                _FullNameInput(),
                const SizedBox(height: 12),
                _EmailInput(),
                const SizedBox(height: 12),
                _PasswordInput(),
                const SizedBox(height: 12),
                _RePasswordInput(),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Align(
            child: _BtnSignUp(),
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

class _FullNameInput extends ConsumerWidget {
  const _FullNameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpProvider);
    return NdTextFieldWidget(
      labelText: 'Họ và Tên',
      hintText: 'Họ và Tên',
      borderRadius: 40,
      onChanged: (value) {
        ref.read(signUpProvider.notifier).onFullNameChange(value);
      },
      error: state.fullName.invalid
          ? state.fullName.error!.getError(context)
          : null,
    );
  }
}

class _EmailInput extends ConsumerWidget {
  const _EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpProvider);
    return NdTextFieldWidget(
      labelText: 'Email',
      hintText: 'Email',
      borderRadius: 40,
      onChanged: (value) {
        ref.read(signUpProvider.notifier).onEmailChange(value);
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
    final state = ref.watch(signUpProvider);
    return NdTextFieldWidget(
      labelText: 'Mật khẩu',
      hintText: 'Mật khẩu',
      borderRadius: 40,
      isPasswordField: true,
      onChanged: (value) {
        ref.read(signUpProvider.notifier).onPasswordChange(value);
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
    final state = ref.watch(signUpProvider);
    return NdTextFieldWidget(
      labelText: 'Nhập lại mật khẩu',
      hintText: 'Nhập lại mật khẩu',
      borderRadius: 40,
      isPasswordField: true,
      onChanged: (value) {
        ref.read(signUpProvider.notifier).onRePasswordChange(value);
      },
      error: state.rePassword.invalid
          ? state.rePassword.error!.getError(context)
          : null,
    );
  }
}

class _BtnSignUp extends ConsumerWidget {
  const _BtnSignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpProvider);
    return GFButton(
      shape: GFButtonShape.pills,
      text: 'Đăng ký'.toUpperCase(),
      color: Theme.of(context).primaryColor,
      textStyle: GoogleFonts.montserrat(
          fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      size: 40,
      onPressed: () {
        if (state.status == FormzStatus.valid ||
            state.status == FormzStatus.submissionFailure) {
          Loading(context).start();
          ref.read(signUpProvider.notifier).onSignUp();
        }
      },
    );
  }
}
