import 'package:app_example/app/constants/api_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:date_format/date_format.dart';

import '../../../../../constants/app_theme.dart';
import '../../../../widgets/text_widget.dart';
import '../../../home/model/service_model.dart';

class DichvudadungItemWidget extends StatelessWidget {
  const DichvudadungItemWidget({Key? key, required this.model}) : super(key: key);
  final ServiceModel model;

  final TextStyle _ngayStyle = const TextStyle(
    color: AppColors.COLOR_VANG_CAT_NHAT,
  );
  final TextStyle _tieudeDichvuDaDUng = const TextStyle(color: AppColors.COLOR_VANG_COM, fontWeight: FontWeight.w500);
  final TextStyle _motaDichvuDaDUng = const TextStyle(color: AppColors.COLOR_VANG_CAT_NHAT, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
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
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(1),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: AppColors.COLOR_XANH_REU_DAM),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                child: SizedBox(
                  width: 110,
                  height: 110,
                  child: Image.network(
                    ApiUrl.upload_news_l + model.photo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: SvgPicture.asset(
                            'assets/icons/calendar.svg',
                            width: 16,
                            height: 16,
                          ),
                        ),
                        Expanded(
                          child: TextWidget(
                              value: formatDate(DateTime.fromMillisecondsSinceEpoch(model.createdDate * 1000), [
                                dd,
                                ' Tháng ',
                                m,
                                " ",
                                yyyy
                              ]).toString(),
                              lineheight: 14 / 11,
                              size: 11,
                              style: _ngayStyle),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextWidget(
                      value: model.name,
                      lineheight: 19 / 15,
                      size: 15,
                      style: _tieudeDichvuDaDUng,
                      maxLine: 1,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.COLOR_XANH_REU_NHAT),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: TextWidget(value: model.desc, lineheight: 14 / 11, size: 11, style: _motaDichvuDaDUng, maxLine: 3, textAlign: TextAlign.justify),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
