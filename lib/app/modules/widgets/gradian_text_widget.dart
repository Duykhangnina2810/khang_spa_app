import 'package:flutter/material.dart';

import 'text_widget.dart';

class GradianTextWidget extends StatelessWidget {
  const GradianTextWidget({Key? key, required this.text, required this.gradient}) : super(key: key);

  final TextWidget text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: text,
    );
  }
}
