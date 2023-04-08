import 'dart:developer';

import 'package:app_example/app/modules/main/search/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_theme.dart';
import '../../home/screen/widgets/user_avatar_widget.dart';
import 'widget/search_notsubmit_widget.dart';
import 'widget/search_sumbit_widget.dart';
import 'widget/search_widget_default.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final TextStyle hintStyle = TextStyle(color: AppColors.COLOR_VANG_CAT_NHAT.withOpacity(0.3), fontSize: 11);
  final double defaultPadding = 20;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const UserAvatarWidget(
          avata: "https://antimatter.vn/wp-content/uploads/2022/11/hinh-anh-gai-xinh-trung-quoc.jpg",
          name: "User",
          status: "online",
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
        child: SafeArea(
          child: Column(
            children: [
              // Thanh tìm kiếm
              Consumer(builder: (context, ref, child) {
                searchController.text = ref.watch(keywordSelectedProvider);
                return SizedBox(
                  height: 40,
                  child: TextField(
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        ref.read(keywordProvider.notifier).update((state) => value);
                        ref.read(searchNotifierProvider.notifier).saveKeyword(value);
                      } else {
                        ref.read(keywordProvider.notifier).update((state) => '');
                      }
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        ref.read(keywordNotSubmitProvider.notifier).update((state) => value);
                      } else {
                        ref.read(keywordNotSubmitProvider.notifier).update((state) => '');
                        ref.read(keywordSelectedProvider.notifier).update((state) => '');
                      }
                    },
                    controller: searchController,
                    cursorColor: AppColors.COLOR_TRANG,
                    maxLines: 1,
                    style: const TextStyle(color: AppColors.COLOR_TRANG),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: AppColors.COLOR_VANG_CAT_NHAT),
                        borderRadius: BorderRadius.all(
                          Radius.circular(1000),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: AppColors.COLOR_VANG_CAT_NHAT),
                        borderRadius: BorderRadius.all(
                          Radius.circular(1000),
                        ),
                      ),
                      hintText: "Tìm dịch vụ bạn muốn trãi nghiệm...",
                      hintStyle: hintStyle,
                      suffixIcon: Padding(padding: const EdgeInsets.all(11), child: SvgPicture.asset("assets/icons/search.svg", width: 15, height: 15)),
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.only(left: 20, right: 15),
                    ),
                  ),
                );
              }),
              // Nội dung
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final kw = ref.watch(keywordProvider);
                    final kwNotSubmit = ref.watch(keywordNotSubmitProvider);
                    if (kw.isNotEmpty) {
                      final searchItem = ref.watch(future_searchItem_provider);
                      return searchItem.when(
                        data: (data) {
                          return SearchSumbitWidget(keyword: kw, models: data);
                        },
                        error: (error, stackTrace) {
                          log(error.toString());
                          return Container();
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    } else if (kwNotSubmit.isNotEmpty) {
                      return const SearchNotsubmitWidget();
                    } else {
                      return const SearchWidgetDefault();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
