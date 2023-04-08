import 'package:app_example/app/constants/app_theme.dart';
import 'package:app_example/app/modules/main/search/provider/search_provider.dart';
import 'package:app_example/app/modules/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class SearchNotsubmitWidget extends ConsumerWidget {
  const SearchNotsubmitWidget({Key? key}) : super(key: key);

  final TextStyle _homnay = const TextStyle(fontWeight: FontWeight.w500, color: AppColors.COLOR_VANG_CAT_NHAT);
  final TextStyle _xoatatca = const TextStyle(fontWeight: FontWeight.w500, color: AppColors.COLOR_VANG_CAT_NHAT);
  final TextStyle _lishsuitem = const TextStyle(fontWeight: FontWeight.w300, color: Color(0xff757575));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(searchNotifierProvider);
    final lishsuHomnay = ref.watch(searchNotifierProvider.notifier).getKeywordOfDate(DateTime.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextWidget(value: 'Hôm nay', lineheight: 19 / 15, size: 15, style: _homnay),
            InkWell(child: TextWidget(value: 'Xóa tất cả', lineheight: 16 / 13, size: 13, style: _xoatatca))
          ],
        ),
        const SizedBox(height: 9),
        const Divider(height: 1, color: AppColors.COLOR_VANG_CAT_NHAT),
        const SizedBox(height: 23),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              children: lishsuHomnay
                  .map((e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(value: e.name, lineheight: 45 / 13, size: 13, style: _lishsuitem),
                          InkWell(
                            child: SvgPicture.asset('assets/icons/close_square.svg'),
                            onTap: () => ref.read(searchNotifierProvider.notifier).removeKeyword(e.name),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}
