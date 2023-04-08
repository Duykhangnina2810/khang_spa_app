import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../../authentication/provider/auth_controller.dart';
import 'row_info_user.dart';

class ProfileInfo extends ConsumerWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).authUserModel;
    if (user != null) {
      return Column(
        children: [
          RowInfoUser(
            icon: LineIcons.genderless,
            title: 'Giới tính',
            title2: 'Nam',
            onTap: () {},
          ),
          RowInfoUser(
            icon: LineIcons.birthdayCake,
            title: 'Ngày sinh',
            title2: '12-12-2022',
            onTap: null,
          ),
          RowInfoUser(
            icon: LineIcons.addressCard,
            title: 'Địa chỉ',
            title2: '',
            onTap: () {},
          ),
          RowInfoUser(
            icon: LineIcons.envelope,
            title: 'Email',
            title2: user.email,
            onTap: null,
          ),
          RowInfoUser(
            icon: LineIcons.phone,
            title: 'Điện thoại',
            title2: user.phone,
            onTap: null,
          ),
          RowInfoUser(
            icon: LineIcons.lock,
            title: 'Mật khẩu',
            title2: '******************',
            onTap: null,
          ),
        ],
      );
    }
    return Container();
  }
}
