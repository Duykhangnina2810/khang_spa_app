import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../../widgets/pin_code_fields/pin_code_fields.dart';
import '../../../reset_password/layout_reset_password.dart';
import '../../../../../constants/app_ui.dart';
import '../../../../widgets/dialog/material_dialogs.dart';
import '../../../signin/layout_signin.dart';
import 'provider/form_verification_code_controller.dart';

import '../../../../../utils/formz/formz.dart';
import '../../../../widgets/loading/loading.dart';

class FormVerificationCode extends ConsumerWidget {
  const FormVerificationCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(formVerificationCodeProvider.notifier);
    final statePinCode = controller.forgotPasswordState;

    ref.listen(formVerificationCodeProvider, (previous, next) {
      if (next.status == FormzStatus.submissionInProgress ||
          next.reSendStatus == ReSendStatus.loading) {
        Loading(context).start();
      }
      if (next.reSendStatus == ReSendStatus.sended) {
        Loading(context).stop();
      }
      if (next.status == FormzStatus.submissionSuccess) {
        // Xác thực chính chủ email OK thì chuyển qua màn hình đổi lại mật khẩu mới
        context.go(LayoutResetPassword.pathRoute);
      }
      if (next.status == FormzStatus.submissionFailure) {
        Loading(context).stop();
        Dialogs.materialDialog(
          context: context,
          lottieBuilder: Lottie.asset(AppUI.animationIconError),
          title: next.errorMessage,
          autoHide: Duration(seconds: 5),
          barrierDismissible: false,
        );
      }
    });

    return Container(
      margin: const EdgeInsets.only(top: 200),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: MediaQuery.of(context).size.width - 32,
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 8), // Shadow position
                      ),
                    ]),
                child: Column(
                  children: [
                    Text(
                      'Xác thực người dùng'.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600, fontSize: 19),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text:
                            'Vui lòng nhập mã xác thực mà chúng tôi đã gửi vào hộp thư ',
                        children: [
                          TextSpan(
                            text: statePinCode.email.value,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Colors.black, height: 1.8),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 200,
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          ref
                              .read(formVerificationCodeProvider.notifier)
                              .onPinCodeChange(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -22,
                child: Align(
                  child: _BtnSubmit(),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                _BuildReSendPinCode(),
                const SizedBox(height: 15),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_circle_left_outlined,
                        size: 25,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Thoát',
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  onTap: () {
                    context.go(LayoutSignIn.pathRoute);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BtnSubmit extends ConsumerWidget {
  const _BtnSubmit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(formVerificationCodeProvider);

    return GFButton(
      shape: GFButtonShape.pills,
      text: 'Xác thực'.toUpperCase(),
      color: Theme.of(context).primaryColor,
      textStyle: GoogleFonts.montserrat(
          fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      size: 40,
      onPressed: () {
        if (state.status == FormzStatus.valid ||
            state.status == FormzStatus.submissionFailure) {
          ref
              .read(formVerificationCodeProvider.notifier)
              .submitFormVerificationCode();
        }
      },
    );
  }
}

class _BuildReSendPinCode extends ConsumerStatefulWidget {
  const _BuildReSendPinCode({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => __BuildReSendPinCodeState();
}

class __BuildReSendPinCodeState extends ConsumerState<_BuildReSendPinCode> {
  // Step 2
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 60);
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(seconds: 60));
  }

  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final seconds = myDuration.inSeconds;
    return GestureDetector(
      onTap: () {
        if (seconds == 0) {
          ref
              .read(formVerificationCodeProvider.notifier)
              .reSendVerificationCode();
          resetTimer();
          startTimer();
        }
      },
      child: RichText(
        text: TextSpan(
            style: GoogleFonts.montserrat(
                fontSize: 15, color: seconds > 0 ? Colors.grey : Colors.black),
            text: 'Gửi lại mã xác thực ',
            children: seconds > 0 ? [TextSpan(text: '($seconds)')] : null),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    countdownTimer!.cancel();
  }
}
