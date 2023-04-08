import 'package:flutter/material.dart';

import '../../../../../constants/app_theme.dart';
import '../../../../widgets/text_widget.dart';

class SearchNotFoundWidget extends StatelessWidget {
  const SearchNotFoundWidget({Key? key}) : super(key: key);

  final _khongtimthat = const TextStyle(fontWeight: FontWeight.w500, color: AppColors.COLOR_VANG_CAT_NHAT);
  final _xinloi = const TextStyle(fontWeight: FontWeight.w400, color: AppColors.COLOR_VANG_CAT_NHAT);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/search_not_found.png',
              fit: BoxFit.fitWidth,
            )),
        const SizedBox(height: 24),
        TextWidget(value: 'Không tìm thấy', lineheight: 25 / 20, size: 20, style: _khongtimthat),
        const SizedBox(height: 10),
        TextWidget(value: 'Xin lỗi, không tìm thấy từ khóa bạn đã nhập, vui lòng kiểm tra lại hoặc tìm kiếm bằng từ khác', lineheight: 20 / 13, size: 13, style: _xinloi),
      ],
    );
  }
}
