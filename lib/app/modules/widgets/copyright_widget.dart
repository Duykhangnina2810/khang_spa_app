import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class CopyrightWidget extends StatelessWidget {
  const CopyrightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.montserrat(fontSize: 14, color: Color(0xFF424242)),
          children: [
            TextSpan(text: 'Copyright '),
            WidgetSpan(
                child: Icon(
              LineIcons.copyright,
              size: 14,
              color: Color(0xFF424242),
            )),
            TextSpan(text: ' 2023. Design by NiNa.vn'),
          ],
        ),
      ),
    );
  }
}
