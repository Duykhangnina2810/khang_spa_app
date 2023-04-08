import 'package:flutter/material.dart';

import '../../../../../constants/app_theme.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({Key? key, required this.avata, required this.name, required this.status}) : super(key: key);

  final String avata;
  final String name;
  final String status;

  final nameStyle = const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.COLOR_VANG_CAT_NHAT);
  final statusStyle = const TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: AppColors.COLOR_VANG_CAT_NHAT);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(avata),
          backgroundColor: AppColors.COLOR_TRANG,
          radius: 20,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tên
              Text(name, style: nameStyle),
              // Status
              Text(status, style: statusStyle),
            ],
          ),
        )
      ],
    );
  }
}
