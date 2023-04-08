import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_ui.dart';
import '../account/signin/layout_signin.dart';
import '../account/signup/layout_signup.dart';

class MustSignInWidget extends StatelessWidget {
  const MustSignInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: SvgPicture.asset(
                AppUI.authPath,
                color: Colors.grey.shade300,
                height: 130,
              ),
            ),
            Text(
              'Xin Chào !',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black54),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style:
                      GoogleFonts.roboto(fontSize: 17, color: Colors.black45),
                  text:
                      'Cảm ơn bạn đã sử dụng ứng dụng của chúng tôi. Tuy nhiên bạn cần phải ',
                  children: [
                    TextSpan(
                        text: 'đăng nhập',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' để có thể trải nghiệm các tính năng này.'),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Mong bạn thông cảm vì sự bất tiện này.',
              style: GoogleFonts.roboto(fontSize: 17, color: Colors.black45),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            GFButton(
              onPressed: () {
                context.go(LayoutSignIn.pathRoute);
              },
              text: 'Đăng nhập'.toUpperCase(),
              textStyle: GoogleFonts.roboto(fontSize: 17, color: Colors.white),
              fullWidthButton: true,
              color: Colors.blueAccent,
              size: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            const SizedBox(
              height: 15,
            ),
            GFButton(
              onPressed: () {
                context.go(LayoutSignUp.pathRoute);
              },
              text: 'Đăng ký'.toUpperCase(),
              textStyle: GoogleFonts.roboto(fontSize: 17, color: Colors.white),
              fullWidthButton: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              size: 50,
              color: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }
}
