import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/api_url.dart';
import '../../../../constants/app_theme.dart';
import '../../../widgets/gradian_text_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../search/screen/widget/search_not_found_widget.dart';
import '../provider/service_detail_provider.dart';

class ServiceDetailScreen extends ConsumerWidget {
  const ServiceDetailScreen({super.key});
  final _appbartitle = const TextStyle(color: AppColors.COLOR_VANG_CAT_NHAT, fontWeight: FontWeight.w500);
  final _titleMain = const TextStyle(fontWeight: FontWeight.w500);
  final _destMain = const TextStyle(fontWeight: FontWeight.w500, color: AppColors.COLOR_XANH_REU_NHAT);
  final _hinhanhvavideo = const TextStyle(fontWeight: FontWeight.w500, color: AppColors.COLOR_VANG_CAT_NHAT);
  final double mainPadding = 25;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(future_serviceDetail_provider);
    final maxWidth = MediaQuery.of(context).size.width - mainPadding * 2;
    return item.when(
      data: (data) {
        return Scaffold(
            appBar: AppBar(
              title: TextWidget(value: data.name, lineheight: 25 / 20, size: 20, style: _appbartitle),
            ),
            body: data.id > 0
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: mainPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(10)), child: SizedBox(width: double.infinity, height: 226, child: Image.network(ApiUrl.upload_news_l + data.photo, fit: BoxFit.fitWidth))),
                          const SizedBox(height: 25),
                          GradianTextWidget(text: TextWidget(value: data.name, lineheight: 25 / 20, size: 20, style: _titleMain), gradient: AppColors.COLOR_VANG_ANH_KIM),
                          const SizedBox(height: 30),
                          Container(
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: AppColors.COLOR_TRANG),
                            padding: const EdgeInsets.only(top: 21, left: 25, right: 15, bottom: 22),
                            child: TextWidget(value: data.description, lineheight: 25 / 13, size: 13, style: _destMain),
                          ),
                          // Cụm 4 hình
                          if (data.gallery.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(value: 'Hình ảnh & video', lineheight: 19 / 15, size: 15, style: _hinhanhvavideo)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6, top: 16),
                                  child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(10)), child: Image.network(ApiUrl.upload_news_l + data.gallery.first)),
                                ),
                                if (data.gallery.length > 1)
                                  Wrap(
                                    spacing: 6,
                                    children: data.gallery
                                        .skip(1)
                                        .map((e) => ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              child: SizedBox(
                                                  width: maxWidth / 3 - 6 * 3 / 2,
                                                  height: 100,
                                                  child: Image.network(
                                                    ApiUrl.upload_news_l + e,
                                                    fit: BoxFit.cover,
                                                  )),
                                            ))
                                        .toList(),
                                  )
                              ],
                            ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: SearchNotFoundWidget(),
                  ));
      },
      error: (error, stackTrace) {
        log(error.toString());
        return const Scaffold();
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
