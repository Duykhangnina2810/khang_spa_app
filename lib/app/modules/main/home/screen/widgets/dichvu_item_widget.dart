import 'package:app_example/app/modules/main/service_detail/layout_service_detail.dart';
import 'package:app_example/app/modules/main/service_detail/provider/service_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/api_url.dart';
import '../../../../../constants/app_theme.dart';
import '../../../../widgets/text_widget.dart';
import '../../model/service_model.dart';
import '../../provider/home_provider.dart';

class DichvuItemWidget extends ConsumerWidget {
  const DichvuItemWidget({Key? key, required this.width, required this.model}) : super(key: key);

  final double width;
  final ServiceModel model;

  final TextStyle _nameStyle = const TextStyle(
    color: AppColors.COLOR_VANG_COM,
    fontWeight: FontWeight.w500,
  );

  final TextStyle _descStyle = const TextStyle(
    color: AppColors.COLOR_VANG_CAT_NHAT,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeProvider);
    final listFav = ref.watch(homeProvider.notifier).getFavIds();
    return Container(
      width: width,
      decoration: const BoxDecoration(gradient: AppColors.COLOR_VANG_ANH_KIM, borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
      padding: const EdgeInsets.all(1),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10)), color: AppColors.COLOR_XANH_REU_DAM),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    ref.read(selectedServiceIdProvider.notifier).update((state) => model.id);
                    context.push(LayoutServiceDetail.pathRoute);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: 134,
                        height: 120,
                        child: Image.network(
                          ApiUrl.upload_news_l + model.photo,
                          width: 134,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: TextWidget(
                          value: model.name,
                          lineheight: 16 / 13,
                          size: 13,
                          style: _nameStyle,
                          maxLine: 1,
                        ),
                      ),
                      TextWidget(
                        value: model.desc,
                        lineheight: 14 / 11,
                        size: 11,
                        style: _descStyle,
                        maxLine: 3,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () {
                      listFav.contains(model.id) ? ref.read(homeProvider.notifier).removeFav(model.id) : ref.read(homeProvider.notifier).addFav(model);
                      ref.read(homeProvider.notifier).triggerNotifier();
                    },
                    child: Animate(
                      effects: const [
                        ScaleEffect(alignment: Alignment.center, begin: Offset(1, 1), end: Offset(2, 2), curve: Curves.easeIn),
                        ThenEffect(),
                        ScaleEffect(alignment: Alignment.center, begin: Offset(1, 1), end: Offset(0.5, 0.5), curve: Curves.easeOut),
                      ],
                      target: listFav.contains(model.id) ? 1 : 0,
                      child: Container(
                          decoration: const BoxDecoration(color: AppColors.COLOR_XANH_REU_DAM, borderRadius: BorderRadius.only(topLeft: Radius.circular(24), bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
                          padding: const EdgeInsets.only(top: 8, left: 7, right: 7, bottom: 6),
                          child: ShaderMask(
                            shaderCallback: (bounds) {
                              return listFav.contains(model.id)
                                  ? AppColors.COLOR_VANG_ANH_KIM.createShader(bounds)
                                  : const LinearGradient(colors: [
                                      Colors.white,
                                      Colors.white
                                    ]).createShader(bounds);
                            },
                            child: SvgPicture.asset(
                              'assets/icons/heart.svg',
                              width: 10,
                              height: 10.55,
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
