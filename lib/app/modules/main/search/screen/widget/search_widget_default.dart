import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/app_theme.dart';
import '../../../../widgets/text_widget.dart';
import '../../provider/search_provider.dart';

class SearchWidgetDefault extends StatelessWidget {
  const SearchWidgetDefault({Key? key}) : super(key: key);

  final TextStyle _lichsutimkiem = const TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.COLOR_VANG_CAT_NHAT,
  );
  final TextStyle _lichsutimkiemitem = const TextStyle(
    fontWeight: FontWeight.w300,
    color: AppColors.COLOR_XANH_REU_NHAT,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          TextWidget(value: 'Lịch sử tìm kiếm', lineheight: 19 / 15, size: 15, style: _lichsutimkiem),
          const SizedBox(
            height: 20,
          ),
          Consumer(builder: (context, ref, child) {
            final lichsu = ref.watch(searchNotifierProvider);
            return Wrap(
              spacing: 12,
              runSpacing: 10,
              children: lichsu.searchKeywords
                  .map((e) => InkWell(
                        onTap: () => ref.read(keywordSelectedProvider.notifier).update((state) => e.name),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          child: Container(
                            color: AppColors.COLOR_VANG_CAT_NHAT,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                            child: TextWidget(value: e.name, lineheight: 20 / 11, size: 11, style: _lichsutimkiemitem),
                          ),
                        ),
                      ))
                  .toList(),
            );
          }),
          const SizedBox(
            height: 23,
          ),
          TextWidget(value: 'Từ khóa hot', lineheight: 19 / 15, size: 15, style: _lichsutimkiem),
          const SizedBox(
            height: 17,
          ),
          Consumer(builder: (context, ref, child) {
            final hotkw = ref.watch(future_hotkeyword_provider);
            return Wrap(
                spacing: 12,
                runSpacing: 10,
                children: hotkw.when(
                  data: (data) {
                    return data
                        .map((e) => InkWell(
                              onTap: () => ref.read(keywordSelectedProvider.notifier).update((state) => e),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                                child: Container(
                                  color: AppColors.COLOR_VANG_CAT_NHAT,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                                  child: TextWidget(value: e, lineheight: 20 / 11, size: 11, style: _lichsutimkiemitem),
                                ),
                              ),
                            ))
                        .toList();
                  },
                  error: (error, stackTrace) {
                    log(error.toString());
                    return [
                      Container()
                    ];
                  },
                  loading: () => [
                    const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  ],
                ));
          }),
        ],
      ),
    );
  }
}
