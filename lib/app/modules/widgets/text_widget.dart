import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({Key? key, required this.value, required this.lineheight, required this.size, required this.style, this.maxLine, this.textAlign, this.softWrap}) : super(key: key);

  final int? maxLine;
  final TextAlign? textAlign;
  final String value;
  final double lineheight;
  final double size;
  final TextStyle style;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = (lineheight * size - size) / 2;
    final double baseline = lineheight * size - lineheight * size / 4;
    return Container(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Baseline(
        baseline: baseline,
        baselineType: TextBaseline.alphabetic,
        child: Text(
          value,
          maxLines: maxLine,
          textAlign: textAlign,
          style: style.copyWith(
            height: lineheight,
            fontSize: size,
          ),
          softWrap: softWrap,
        ),
      ),
    );
  }
}
