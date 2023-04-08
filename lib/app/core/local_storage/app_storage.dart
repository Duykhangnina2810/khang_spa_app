import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants/app_settings.dart';
import 'package:path/path.dart' as p;

import '../../modules/main/home/model/service_model.dart';
import '../../modules/main/search/model/search_model.dart';

class AppStorage {
  late Box _boxSettings;
  late Box _boxAuth;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SearchModelAdapter());
    Hive.registerAdapter(ServiceModelAdapter());

    _boxSettings = await openBox(AppSettings.boxSettings);
    _boxAuth = await openBox(AppSettings.boxAuth);

    await Hive.openBox<SearchModel>(AppSettings.boxSearch);
    await Hive.openBox<ServiceModel>(AppSettings.boxService);
  }

  Box? get boxSettings => _boxSettings;

  Future<Box> openBox(String nameBox) async {
    return await Hive.openBox(nameBox);
  }

  Box selectBox(String nameBox) {
    return Hive.box(nameBox);
  }

  Future<int> clearBox(Box box) {
    return box.clear();
  }

  Future<void> deleteBox({required Box box, required String key}) {
    return box.delete(key);
  }

  dynamic getBox({required Box box, required String key}) {
    return box.get(key);
  }

  Future<void> saveBox({required Box box, required String key, required dynamic value}) {
    return box.put(key, value);
  }

  clearAll() async {
    _boxSettings.clear();
    _boxAuth.clear();
    final appDir = await getApplicationDocumentsDirectory();
    var files = appDir.listSync();
    for (var file in files) {
      if (file.statSync().type == FileSystemEntityType.file && p.extension(file.path).toLowerCase() == '.hive') {
        var box = await Hive.openBox(p.basenameWithoutExtension(file.path));
        box.clear();
      }
    }
  }

  printBox(Box nameBox) {
    nameBox.toMap().forEach((key, value) {
      print("'$key' : '$value'");
    });
  }
}
