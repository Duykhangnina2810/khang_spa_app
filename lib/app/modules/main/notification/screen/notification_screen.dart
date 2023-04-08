import 'package:app_example/app/modules/main/home/provider/home_provider.dart';
import 'package:app_example/app/modules/main/notification/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_theme.dart';
import '../../../widgets/text_widget.dart';
import 'widget/dichvudadung_item_widget.dart';
import 'widget/thongbao_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  int _selectedindex = 0;

  late TabController _tab;

  @override
  void initState() {
    // TODO: implement initState
    _tab = TabController(length: 3, vsync: this);
    super.initState();
  }

  final double defaultPadding = 24;

  final TextStyle _tieuDeThongBao = const TextStyle(fontWeight: FontWeight.w500, color: AppColors.COLOR_VANG_CAT_NHAT);

  final TextStyle _tieuDeTabActive = const TextStyle(fontWeight: FontWeight.w500, color: AppColors.COLOR_VANG_COM);

  final TextStyle _tieuDeTab = const TextStyle(fontWeight: FontWeight.w500, color: AppColors.COLOR_VANG_CAT_NHAT);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(value: 'Thông báo', lineheight: 25 / 20, size: 20, style: _tieuDeThongBao),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Stack(
                  children: [
                    Positioned(top: 0, left: defaultPadding, right: defaultPadding, child: const Divider(height: 1, color: AppColors.COLOR_XANH_REU_NHAT)),
                    TabBar(
                      controller: _tab,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 30),
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(width: 1, color: AppColors.COLOR_VANG_COM),
                        insets: EdgeInsets.only(bottom: 46),
                      ),
                      onTap: (value) => setState(() {
                        _selectedindex = value;
                      }),
                      tabs: [
                        Tab(
                          child: TextWidget(
                            value: 'Tất cả',
                            lineheight: _selectedindex == 0 ? 19 / 15 : 16 / 13,
                            size: _selectedindex == 0 ? 15 : 13,
                            style: _selectedindex == 0 ? _tieuDeTabActive : _tieuDeTab,
                          ),
                        ),
                        Tab(
                          child: TextWidget(
                            value: 'Ưu đãi',
                            lineheight: _selectedindex == 2 ? 19 / 15 : 16 / 13,
                            size: _selectedindex == 1 ? 15 : 13,
                            style: _selectedindex == 1 ? _tieuDeTabActive : _tieuDeTab,
                          ),
                        ),
                        Tab(
                          child: TextWidget(
                            value: 'Dịch vụ đã dùng',
                            lineheight: _selectedindex == 2 ? 19 / 15 : 16 / 13,
                            size: _selectedindex == 2 ? 15 : 13,
                            style: _selectedindex == 2 ? _tieuDeTabActive : _tieuDeTab,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(color: AppColors.COLOR_XANH_REU_NHAT, borderRadius: BorderRadius.all(Radius.circular(30))),
                          child: Container(
                            padding: EdgeInsets.all(defaultPadding),
                            decoration: const BoxDecoration(color: AppColors.COLOR_XANH_REU_DAM, borderRadius: BorderRadius.all(Radius.circular(30))),
                            child: Column(
                              children: [
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(color: AppColors.COLOR_XANH_REU_NHAT, borderRadius: BorderRadius.all(Radius.circular(30))),
                          child: Container(
                            padding: EdgeInsets.all(defaultPadding),
                            decoration: const BoxDecoration(color: AppColors.COLOR_XANH_REU_DAM, borderRadius: BorderRadius.all(Radius.circular(30))),
                            child: Column(
                              children: [
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                                ThongbaoItem(
                                  model: NotificationModel(
                                    name: 'Khuyến mãi 20% dịch vụ',
                                    desc: 'Lần đầu khi sử dụng các loại dịch vụ được khách hàng yêu cầu',
                                    photo: 'https://i.pinimg.com/736x/05/e8/da/05e8dac6dd3b289e26c11c766956a785.jpg',
                                    status: 'uu-dai',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(color: AppColors.COLOR_XANH_REU_NHAT, borderRadius: BorderRadius.all(Radius.circular(30))),
                          child: Container(
                            padding: EdgeInsets.all(defaultPadding),
                            decoration: const BoxDecoration(color: AppColors.COLOR_XANH_REU_DAM, borderRadius: BorderRadius.all(Radius.circular(30))),
                            child: Consumer(
                              builder: (context, ref, child) {
                                final list = ref.watch(future_Service_Provider);
                                return list.when(
                                  data: (data) {
                                    return Wrap(
                                      runSpacing: 10,
                                      children: data.map((e) => DichvudadungItemWidget(model: e)).toList(),
                                    );
                                  },
                                  error: (error, stackTrace) => Center(
                                    child: Text(error.toString()),
                                  ),
                                  loading: () => const Center(
                                    child: LinearProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
