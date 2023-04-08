import 'package:flutter/material.dart';

import '../../../../constants/app_theme.dart';


class RowInfoUser extends StatelessWidget {
  const RowInfoUser(
      {Key? key,
      this.pathIcon,
      required this.title,
      this.onTap,
      this.title2,
      this.colorIcon,
      this.icon})
      : super(key: key);

  final String? pathIcon;
  final IconData? icon;
  final Color? colorIcon;
  final String title;
  final String? title2;
  final VoidCallback? onTap;

  // Title
  static const TextStyle titleMain = TextStyle(
      color: AppColors.COLOR_PRIMARY, fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          children: [
            if (pathIcon != null) ...[
              Image.asset(
                pathIcon!,
                color: colorIcon ?? Theme.of(context).primaryColor,
                width: 24,
                height: 24,
              )
            ] else ...[
              Icon(
                icon,
                size: 24,
                color: colorIcon ?? Theme.of(context).primaryColor,
              )
            ],
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                title,
                style: titleMain,
              ),
            ),
            if (title2 != null) ...[
              Container(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  title2 ?? '',
                  style: const TextStyle(color: AppColors.COLOR_PRIMARY),
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              Container(
                padding: const EdgeInsets.only(top: 4),
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                  size: 29,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
