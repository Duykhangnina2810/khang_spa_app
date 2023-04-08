import 'package:app_example/app/constants/api_url.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../../../../../constants/app_theme.dart';
import '../../../../widgets/text_widget.dart';

class TieuchiItemWidget extends StatelessWidget {
  const TieuchiItemWidget({Key? key, required this.photo, required this.title}) : super(key: key);

  final String photo;
  final String title;

  final TextStyle _tieuchiTitle = const TextStyle(
    color: AppColors.COLOR_VANG_CAT_NHAT,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), bottomLeft: Radius.circular(100), bottomRight: Radius.circular(100)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 10,
            inset: true,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundImage: NetworkImage(ApiUrl.upload_news_l + photo),
                radius: 25,
              )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                value: title,
                lineheight: 19 / 15,
                size: 15,
                style: _tieuchiTitle,
                maxLine: 1,
              )
            ],
          ))
        ],
      ),
    );
  }
}
