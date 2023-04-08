import 'package:go_router/go_router.dart';

import '../app/modules/main/home/layout_home.dart';
import '../app/modules/main/list_service/layout_list_service.dart';
import '../app/modules/main/notification/layout_notification.dart';
import '../app/modules/main/search/layout_search.dart';
import '../app/modules/main/service_detail/layout_service_detail.dart';

final List<GoRoute> modulesRoutes = [
  // TODO: Danh sách GoRoute của các modules ở đây. Ví dụ: LayoutMain.goRoute(),
  // TODO: Thêm các GoRoute bên dưới...
  LayoutHome.goRoute(),
  LayoutNotification.goRoute(),
  LayoutSearch.goRoute(),
  LayoutListService.goRoute(),
  LayoutServiceDetail.goRoute(),
];
