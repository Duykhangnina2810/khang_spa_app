// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:app_example/app/modules/main/service_detail/model/service_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/api_url.dart';
import '../../home/provider/home_provider.dart';

final selectedServiceIdProvider = StateProvider<int>((ref) => 0);

final future_serviceDetail_provider = FutureProvider<ServiceDetailModel>((ref) async {
  final id = ref.watch(selectedServiceIdProvider);
  // const id = 28;
  if (id > 0) {
    final res = await ref.watch(dioProvider).get(ApiUrl.baseApi + ApiUrl.getServiceDetail, queryParameters: {
      'id': id
    });
    return ServiceDetailModel.fromJson(jsonDecode(res.data));
  }
  return ServiceDetailModel();
});
