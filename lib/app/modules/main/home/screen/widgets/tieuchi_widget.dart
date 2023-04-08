import 'package:app_example/app/constants/app_theme.dart';
import 'package:app_example/app/modules/main/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/gradian_text_widget.dart';
import '../../../../widgets/text_widget.dart';
import 'tieuchi_item_widget.dart';

class TieuchiWidget extends StatelessWidget {
  const TieuchiWidget({Key? key}) : super(key: key);

  final _tieuChiTitle1 = const TextStyle(
    fontWeight: FontWeight.w500,
  );

  final _tieuChiTitle2 = const TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.COLOR_VANG_CAT_NHAT,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 22),
          child: GradianTextWidget(
            text: TextWidget(value: 'Tiêu chí chúng tôi', lineheight: 25 / 20, size: 20, style: _tieuChiTitle1),
            gradient: const LinearGradient(
              colors: [
                Color(0xffF8F67A),
                Color(0xffF6EF5A),
                Color(0xffF4DD47),
                Color(0xffC2A131),
                Color(0xff92651D),
                Color(0xffC6A837),
                Color(0xffF6EB59),
                Color(0xffF9F678),
                Color(0xffF9F899),
                Color(0xffF9F678),
                Color(0xffF6EB59),
                Color(0xffCCA134),
                Color(0xff9F591D),
              ],
              transform: GradientRotation(69.52),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 7),
          child: TextWidget(
            value: 'Những lý do bạn nên đến với spa chúng tôi để trãi nghiệm những dịch vụ tốt nhất',
            lineheight: 16 / 13,
            size: 13,
            style: _tieuChiTitle2,
            textAlign: TextAlign.center,
          ),
        ),

        // Tiêu chí items
        Consumer(
          builder: (context, ref, child) {
            final tieuchi = ref.watch(future_Criteria_Provider);
            return tieuchi.when(
              data: (data) {
                return Wrap(
                  runSpacing: 20,
                  children: data.map((e) => TieuchiItemWidget(photo: e.photo, title: e.name)).toList(),
                );
              },
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => const Center(
                child: LinearProgressIndicator(),
              ),
            );
          },
        ),
      ],
    );
  }
}
