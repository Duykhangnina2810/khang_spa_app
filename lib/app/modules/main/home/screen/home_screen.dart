import 'package:app_example/app/constants/api_url.dart';
import 'package:app_example/app/modules/main/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_theme.dart';
import '../../../widgets/separator_widget.dart';
import 'widgets/dichvu_tab_widget.dart';
import 'widgets/search_input_widget.dart';
import 'widgets/tieuchi_widget.dart';
import 'widgets/user_avatar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final double mainPadding = 25;

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mainPadding),
              child: const SearchInputWidget(hint: "Tìm dịch vụ bạn muốn trãi nghiệm..."),
            ),

            // Slide
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mainPadding),
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                child: Consumer(
                  builder: (context, ref, child) {
                    final slides = ref.watch(future_Slideshow_Provider);
                    return slides.when(
                      data: (data) {
                        return GFCarousel(
                            height: 170,
                            viewportFraction: 1.0,
                            hasPagination: true,
                            pagerSize: 10,
                            passiveIndicator: AppColors.COLOR_TRANG,
                            activeIndicator: AppColors.COLOR_XANH_REU_DAM,
                            enlargeMainPage: true,
                            items: data
                                .map((e) => SizedBox(
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        child: Image.network(
                                          ApiUrl.upload_photo_l + e.photo,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ))
                                .toList());
                      },
                      error: (error, stackTrace) => Center(
                        child: Text(
                          error.toString(),
                        ),
                      ),
                      loading: () => const Center(
                        child: LinearProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Grid dichvu
            const DichvuTabWidget(),

            // seperate line
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mainPadding),
              child: const SeparatorWidget(
                height: 1,
                color: AppColors.COLOR_XANH_REU_NHAT,
              ),
            ),

            // Tiêu chí
            Padding(
              padding: EdgeInsets.only(bottom: 54, left: mainPadding, right: mainPadding),
              child: const TieuchiWidget(),
            ),

            const SizedBox(
              height: 54,
            )
          ],
        ),
      ),
    );
  }
}
