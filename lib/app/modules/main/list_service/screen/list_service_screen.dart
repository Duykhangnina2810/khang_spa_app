import 'package:app_example/app/modules/main/home/provider/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_theme.dart';
import '../../../widgets/text_widget.dart';
import '../../home/provider/home_provider.dart';
import '../../home/screen/widgets/dichvu_grid_widget.dart';
import '../../home/screen/widgets/search_input_widget.dart';

class ListServiceScreen extends StatefulWidget {
  const ListServiceScreen({Key? key}) : super(key: key);

  @override
  State<ListServiceScreen> createState() => _ListServiceScreenState();
}

class _ListServiceScreenState extends State<ListServiceScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;
  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
  }

  final _appbartitle = const TextStyle(color: AppColors.COLOR_VANG_CAT_NHAT, fontWeight: FontWeight.w500);
  final double mainPadding = 25;

  final TextStyle _tabTextStyle = const TextStyle(
    color: Color(0xff141414),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(value: "Dịch vụ chúng tôi", lineheight: 25 / 20, size: 20, style: _appbartitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mainPadding),
            child: const SearchInputWidget(hint: "Tìm dịch vụ bạn muốn trãi nghiệm..."),
          ),
          const SizedBox(height: 21),
          Consumer(builder: (context, ref, child) {
            final selectedIndex = ref.watch(serviceListId).selectedIndex;
            final list = ref.watch(future_ServiceList_Provider);
            return Padding(
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
            );
          }),
          Expanded(child: SingleChildScrollView(
            child: Consumer(
              builder: (context, ref, child) {
                final services = ref.watch(future_Service_Provider);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: mainPadding),
                  child: services.when(
                    data: (data) {
                      return DichvuGridWidget(data: data, columnGap: 17, rowGap: 16, column: 2);
                    },
                    error: (error, stackTrace) => Center(
                      child: Text(error.toString()),
                    ),
                    loading: () => const Center(
                      child: LinearProgressIndicator(),
                    ),
                    skipLoadingOnRefresh: false,
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
