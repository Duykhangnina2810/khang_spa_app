class ServiceDetailModel {
  late String name;
  late String description;
  late int createdDate;
  late int id;
  late String photo;
  late List<String> gallery;

  ServiceDetailModel({this.name = "", this.description = "", this.createdDate = 0, this.id = 0, this.photo = "", this.gallery = const []});

  ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    createdDate = json['created_date'];
    id = json['id'];
    photo = json['photo'];
    gallery = json['gallery'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['created_date'] = createdDate;
    data['id'] = id;
    data['photo'] = photo;
    data['gallery'] = gallery;
    return data;
  }
}
