import 'package:flutter/material.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';

class ButtonIconSocial extends StatelessWidget {
  const ButtonIconSocial(
      {Key? key,
      required this.onTap,
      this.iconPath,
      this.isLoading = false,
      this.icon})
      : super(key: key);

  final VoidCallback onTap;
  final String? iconPath;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(50)),
        child: (isLoading == true)
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              )
            : (iconPath != null)
                ? GFImageOverlay(
                    colorFilter: null,
                    image: AssetImage(iconPath ?? ''),
                    boxFit: BoxFit.fitHeight,
                    height: 24,
                    width: 24,
                  )
                : (icon != null)
                    ? Icon(icon)
                    : null,
      ),
    );
  }
}
