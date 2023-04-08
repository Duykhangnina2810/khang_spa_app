import 'package:app_example/app/modules/main/home/provider/home_state.dart';
import 'package:app_example/app/modules/main/list_service/layout_list_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/app_theme.dart';
import '../../../../widgets/text_widget.dart';
import '../../model/service_model.dart';
import '../../provider/home_provider.dart';
import 'dichvu_grid_widget.dart';

class DichvuTabWidget extends ConsumerStatefulWidget {
  const DichvuTabWidget({Key? key}) : super(key: key);
  @override
  ConsumerState<DichvuTabWidget> createState() => _DichvuTabWidgetState();
}

class _DichvuTabWidgetState extends ConsumerState<DichvuTabWidget> with SingleTickerProviderStateMixin {
  final double mainPadding = 25;
  late TabController _tab;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tab = TabController(length: 4, vsync: this);
  }

  final TextStyle _dichvuChungtoi = const TextStyle(
    color: AppColors.COLOR_VANG_CAT_NHAT,
    fontWeight: FontWeight.w500,
  );

  final TextStyle _cacDichvu = const TextStyle(
    color: AppColors.COLOR_VANG_CAT_NHAT,
    fontWeight: FontWeight.w500,
  );
  final TextStyle _tabTextStyle = const TextStyle(
    color: Color(0xff141414),
  );

  final TextStyle _nutXemThem = const TextStyle(
    color: AppColors.COLOR_VANG_COM,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(future_ServiceList_Provider);
    final selectedIndex = ref.watch(serviceListId).selectedIndex;
    AsyncValue<List<ServiceModel>> services = ref.watch(future_Service_Provider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 2 dòng chữ
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: TextWidget(value: 'Dịch vụ chúng tôi', lineheight: 25 / 20, size: 20, style: _dichvuChungtoi),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: TextWidget(value: 'Các dịch vụ chúng tôi hiện nay', lineheight: 16 / 13, size: 13, style: _cacDichvu),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(left: mainPadding),
          child: list.when(
            data: (data) {
              List<Widget> result = [
                Container(
                  decoration: BoxDecoration(color: selectedIndex == 0 ? AppColors.COLOR_VANG_COM : AppColors.COLOR_TRANG, borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                  child: TextWidget(value: 'All', lineheight: 16 / 13, size: 13, style: _tabTextStyle),
                ),
              ];

              result.addAll(data
                  .asMap()
                  .entries
                  .map(
                    (e) => Container(
                      decoration: BoxDecoration(color: selectedIndex == e.key + 1 ? AppColors.COLOR_VANG_COM : AppColors.COLOR_TRANG, borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                      child: TextWidget(value: e.value.namevi, lineheight: 16 / 13, size: 13, style: _tabTextStyle),
                    ),
                  )
                  .toList());

              return Padding(
                padding: const EdgeInsets.only(bottom: 22),
                child: TabBar(
                  onTap: (value) => ref.read(serviceListId.notifier).update((state) => ServiceListIdState(id: value - 1 > -1 ? list.value!.elementAt(value - 1).id : 0, selectedIndex: value)),
                  indicatorColor: Colors.transparent,
                  controller: _tab,
                  isScrollable: true,
                  labelPadding: const EdgeInsets.only(right: 10),
                  tabs: result,
                ),
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const Center(
              child: LinearProgressIndicator(),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainPadding),
          child: services.when(
            data: (data) {
              return DichvuGridWidget(data: data.take(4).toList(), columnGap: 17, rowGap: 16, column: 2);
            },
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const Center(
              child: LinearProgressIndicator(),
            ),
            skipLoadingOnRefresh: false,
          ),
        ),

        // Nút xem thêm
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 21, bottom: 30, left: mainPadding, right: mainPadding),
          child: InkWell(
            onTap: () {
              context.push(LayoutListService.pathRoute);
            },
            child: Container(
              decoration: const BoxDecoration(gradient: AppColors.COLOR_VANG_ANH_KIM, borderRadius: BorderRadius.all(Radius.circular(30))),
              padding: const EdgeInsets.all(1),
              child: Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: AppColors.COLOR_XANH_REU_DAM),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(value: 'Xem thêm dịch vụ', lineheight: 16 / 13, size: 13, style: _nutXemThem),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
