class CriteriaModel {
  late String name;
  late String desc;
  late int createdDate;
  late int id;
  late String photo;

  CriteriaModel({this.name = "", this.desc = "", this.createdDate = 0, this.id = 0, this.photo = ""});

  CriteriaModel.fromJson(Map<String, dynamic> json) {
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

  CriteriaModel copyWith({String? name, String? description, int? createdDate, int? id, String? photo}) {
    return CriteriaModel(name: name ?? this.name, desc: description ?? desc, createdDate: createdDate ?? this.createdDate, id: id ?? this.id, photo: photo ?? this.photo);
  }
}
