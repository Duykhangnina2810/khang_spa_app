import 'package:app_example/app/constants/app_theme.dart';
import 'package:app_example/app/modules/main/notification/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../widgets/separator_widget.dart';
import '../../../../widgets/text_widget.dart';

class ThongbaoItem extends StatelessWidget {
  const ThongbaoItem({Key? key, required this.model}) : super(key: key);
  final NotificationModel model;

  final TextStyle _titleStyle = const TextStyle(color: AppColors.COLOR_VANG_CAT_NHAT, fontWeight: FontWeight.w500);
  final TextStyle _descStyle = const TextStyle(color: AppColors.COLOR_VANG_CAT_NHAT, fontWeight: FontWeight.w300);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  width: 68,
                  height: 68,
                  child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(10)), child: Image.network(model.photo, fit: BoxFit.cover)),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Expanded(child: TextWidget(value: model.name, lineheight: 16 / 13, size: 13, style: _titleStyle, maxLine: 1)),
                            SvgPicture.asset('assets/icons/thongbao_3cham.svg', width: 12, height: 12)
                          ],
                        ),
                      ),
                      TextWidget(
                        value: model.desc,
                        lineheight: 20 / 11,
                        size: 11,
                        style: _descStyle,
                        maxLine: 2,
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SeparatorWidget(color: AppColors.COLOR_XANH_REU_NHAT, height: 1)
        ],
      ),
    );
  }
}
