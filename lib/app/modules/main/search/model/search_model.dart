// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive_flutter/hive_flutter.dart';

part 'search_model.g.dart';

@HiveType(typeId: 1)
class SearchModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  DateTime createdDate;

  SearchModel({required this.name, required this.createdDate});

  SearchModel copyWith({String? name, DateTime? createdDate}) {
    return SearchModel(name: name ?? this.name, createdDate: createdDate ?? this.createdDate);
  }
}
