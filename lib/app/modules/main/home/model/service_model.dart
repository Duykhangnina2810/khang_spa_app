import 'package:hive_flutter/hive_flutter.dart';

part 'service_model.g.dart';

@HiveType(typeId: 2)
class ServiceModel {
  @HiveField(0, defaultValue: "")
  late String name;
  @HiveField(1, defaultValue: "")
  late String desc;
  @HiveField(2, defaultValue: 0)
  late int createdDate;
  @HiveField(3, defaultValue: 0)
  late int id;
  @HiveField(4, defaultValue: "")
  late String photo;

  ServiceModel({this.name = "", this.desc = "", this.createdDate = 0, this.id = 0, this.photo = ""});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['description'];
    createdDate = json['created_date'];
    id = json['id'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = desc;
    data['created_date'] = createdDate;
    data['id'] = id;
    data['photo'] = photo;
    return data;
  }

  ServiceModel copyWith({String? name, String? description, int? createdDate, int? id, String? photo}) {
    return ServiceModel(name: name ?? this.name, desc: description ?? desc, createdDate: createdDate ?? this.createdDate, id: id ?? this.id, photo: photo ?? this.photo);
  }
}
