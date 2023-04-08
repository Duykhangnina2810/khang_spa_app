import 'package:app_example/app/modules/main/home/provider/home_provider.dart';
import 'package:app_example/app/modules/main/home/screen/widgets/dichvu_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_theme.dart';
import '../../home/screen/widgets/search_input_widget.dart';
import '../../home/screen/widgets/user_avatar_widget.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  final double defaultPadding = 25;

  @override
  Widget build(context, ref) {
    final models = ref.watch(homeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: UserAvatarWidget(
            avata: "https://antimatter.vn/wp-content/uploads/2022/11/hinh-anh-gai-xinh-trung-quoc.jpg",
            name: "User",
            status: "online",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/notification');
            },
            icon: SvgPicture.asset("assets/icons/notification.svg"),
            color: AppColors.COLOR_VANG_CAT_NHAT,
            iconSize: 24,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SearchInputWidget(
              hint: "Tìm dịch vụ bạn muốn trãi nghiệm...",
            ),
            const SizedBox(height: 21),
            Expanded(child: SingleChildScrollView(child: DichvuGridWidget(data: models.favorites, columnGap: 16, rowGap: 16, column: 2)))
          ],
        ),
      ),
    );
  }
}
