// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:app_example/app/constants/app_settings.dart';
import 'package:app_example/app/modules/main/home/model/criteria_model.dart';
import 'package:app_example/app/modules/main/home/provider/home_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../constants/api_url.dart';
import '../../../../core/service/api/dio_client.dart';
import '../model/service_list_model.dart';
import '../model/service_model.dart';
import '../model/slide_model.dart';

class HomeProvider extends Notifier<ServiceState> {
  final box = Hive.box<ServiceModel>(AppSettings.boxService);
  @override
  ServiceState build() {
    return ServiceState(favorites: box.values.toList(), message: "");
  }

  Future addFav(ServiceModel model) async {
    final idx = state.favorites.indexWhere((e) => e.id == model.id);
    if (idx < 0) {
      await box.add(model);
      state.favorites.add(model);
      state = state.copyWith(message: "");
    } else {
      state = state.copyWith(message: "Dịch vụ đã tồn tại trong mục yêu thích");
    }
  }

  Future removeFav(int id) async {
    final idx = state.favorites.indexWhere((e) => e.id == id);
    if (idx > -1) {
      await box.deleteAt(idx);
      state.favorites.removeAt(idx);
      state = state.copyWith(message: "");
    }
    state = state.copyWith(message: "Dịch vụ không tồn tại trong mục yêu thích");
  }

  Future removeAllFav() async {
    try {
      await box.clear();
      state.favorites.clear();
      state = state.copyWith(message: "");
    } catch (e) {
      state = state.copyWith(message: e.toString());
    }
  }

  void triggerNotifier() {
    state = state.copyWith();
  }

  List<int> getFavIds() {
    final list = box.values.map((e) => e.id).toList();
    return list;
  }
}

final dioProvider = Provider((ref) => DioClient(Dio()));
final serviceListId = StateProvider<ServiceListIdState>((ref) => ServiceListIdState(id: 0, selectedIndex: 0));
final homeProvider = NotifierProvider<HomeProvider, ServiceState>(() => HomeProvider());

// Future provider
final future_Slideshow_Provider = FutureProvider.autoDispose<List<SlideModel>>((ref) async {
  try {
    final res = await ref.watch(dioProvider).get(ApiUrl.baseApi + ApiUrl.getSlideshow);
    return (jsonDecode(res.data) as List).map((e) => SlideModel.fromJson(e)).toList();
  } on DioError {
    rethrow;
  }
});

final future_Service_Provider = FutureProvider.autoDispose((ref) async {
  try {
    String url = "";
    if (ref.watch(serviceListId).id > 0) {
      url = "${ApiUrl.baseApi}${ApiUrl.getServiceWithList}${ref.read(serviceListId).id}";
    } else {
      url = ApiUrl.baseApi + ApiUrl.getService;
    }
    final res = await ref.watch(dioProvider).get(url);
    return (jsonDecode(res.data) as List).map((e) => ServiceModel.fromJson(e)).toList();
  } on DioError {
    rethrow;
  }
});
final future_ServiceList_Provider = FutureProvider.autoDispose((ref) async {
  try {
    final res = await ref.watch(dioProvider).get(ApiUrl.baseApi + ApiUrl.getServiceList);
    return (jsonDecode(res.data) as List).map((e) => ServiceListModel.fromJson(e)).toList();
  } on DioError {
    rethrow;
  }
});
final future_Criteria_Provider = FutureProvider.autoDispose((ref) async {
  try {
    final res = await ref.watch(dioProvider).get(ApiUrl.baseApi + ApiUrl.getCriteria);
    return (jsonDecode(res.data) as List).map((e) => CriteriaModel.fromJson(e)).toList();
  } on DioError {
    rethrow;
  }
});
