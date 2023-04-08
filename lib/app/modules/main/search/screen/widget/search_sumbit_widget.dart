import 'package:app_example/app/modules/main/home/model/service_model.dart';
import 'package:app_example/app/modules/main/search/screen/widget/search_found_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/app_theme.dart';
import '../../../../widgets/text_widget.dart';
import 'search_not_found_widget.dart';

class SearchSumbitWidget extends StatelessWidget {
  const SearchSumbitWidget({Key? key, required this.models, required this.keyword}) : super(key: key);

  final List<ServiceModel> models;
  final String keyword;

  final TextStyle _ketquatimkiem = const TextStyle(fontWeight: FontWeight.w500, color: AppColors.COLOR_VANG_CAT_NHAT);
  final TextStyle _found = const TextStyle(fontWeight: FontWeight.w500, color: AppColors.COLOR_VANG_CAT_NHAT);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: TextWidget(value: 'Kết quả tìm kiếm: "$keyword"', lineheight: 19 / 15, size: 15, style: _ketquatimkiem, maxLine: 1, softWrap: true)),
            Container(margin: const EdgeInsets.only(left: 10), child: InkWell(child: TextWidget(value: '${models.length} found', lineheight: 16 / 13, size: 13, style: _found)))
          ],
        ),
        const SizedBox(height: 9),
        const Divider(height: 1, color: AppColors.COLOR_VANG_CAT_NHAT),
        Expanded(child: models.isEmpty ? const SearchNotFoundWidget() : SearchFoundWidget(models: models)),
      ],
    );
  }
}
