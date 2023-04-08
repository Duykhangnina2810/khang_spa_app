import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/app_theme.dart';
import '../../../search/layout_search.dart';

class SearchInputWidget extends ConsumerWidget {
  const SearchInputWidget({Key? key, required this.hint}) : super(key: key);
  static final TextEditingController searchController = TextEditingController();

  final String hint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle hintStyle = TextStyle(color: AppColors.COLOR_VANG_CAT_NHAT.withOpacity(0.3), fontSize: 11);
    return SizedBox(
      height: 40,
      child: TextField(
        onTap: () => context.push(LayoutSearch.pathRoute),
        controller: searchController,
        cursorColor: AppColors.COLOR_TRANG,
        maxLines: 1,
        readOnly: true,
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
  }
}
