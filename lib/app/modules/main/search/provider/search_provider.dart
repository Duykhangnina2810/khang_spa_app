// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../constants/api_url.dart';
import '../../../../constants/app_settings.dart';
import '../../home/model/service_model.dart';
import '../../home/provider/home_provider.dart';
import '../model/search_model.dart';
import 'search_state.dart';

class SearchProvider extends Notifier<SearchState> {
  final box = Hive.box<SearchModel>(AppSettings.boxSearch);

  @override
  SearchState build() {
    return SearchState(searchKeywords: box.values.toList());
  }

  Future<void> saveKeyword(String keyword) async {
    final idx = state.searchKeywords.indexWhere((e) => e.name.toLowerCase() == keyword.toLowerCase());
    if (idx < 0) {
      await box.add(SearchModel(name: keyword, createdDate: DateTime.now()));
      state.searchKeywords.add(SearchModel(name: keyword, createdDate: DateTime.now()));
      state = state.copyWith();
    }
  }

  Future<void> removeKeyword(String keyword) async {
    final idx = state.searchKeywords.indexWhere((e) => e.name.toLowerCase() == keyword.toLowerCase());
    if (idx > -1) {
      await box.deleteAt(idx);
      state.searchKeywords.removeAt(idx);
      state = state.copyWith();
    }
  }

  Future<void> removeAllKeyword() async {
    await box.clear();
    state.searchKeywords.clear();
    state = state.copyWith();
  }

  List<SearchModel> getKeywordOfDate(DateTime date) {
    final list = state.searchKeywords.where((e) => e.createdDate.year == date.year && e.createdDate.month == date.month && e.createdDate.day == date.day).toList();
    return list;
  }
}

final keywordProvider = StateProvider.autoDispose((ref) {
  final text = ref.watch(keywordSelectedProvider);
  return text;
});
final keywordSelectedProvider = StateProvider((ref) => '');
final keywordNotSubmitProvider = StateProvider.autoDispose((ref) => '');
final searchNotifierProvider = NotifierProvider<SearchProvider, SearchState>(() => SearchProvider());

final future_searchItem_provider = FutureProvider.autoDispose<List<ServiceModel>>((ref) async {
  final kw = ref.watch(keywordProvider);
  if (kw.isNotEmpty) {
    final res = await ref.watch(dioProvider).get(ApiUrl.baseApi + ApiUrl.getSearch, queryParameters: {
      'keyword': kw
    });
    return (jsonDecode(res.data) as List).map((e) => ServiceModel.fromJson(e)).toList();
  }
  return <ServiceModel>[];
});

final future_hotkeyword_provider = FutureProvider.autoDispose((ref) async {
  final res = await ref.watch(dioProvider).get(ApiUrl.baseApi + ApiUrl.getHotKeyword);
  return (jsonDecode(res.data) as List).map((e) => e['name'].toString()).toList();
});
