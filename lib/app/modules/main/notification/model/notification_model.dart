class NotificationModel {
  late int id;
  late String photo;
  late String name;
  late String desc;
  late String status;

  NotificationModel({this.id = 0, this.photo = "", this.name = "", this.desc = "", this.status = ""});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    desc = json['desc'] ?? "";
    status = json['status'] ?? "";
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    data['desc'] = desc;
    data['status'] = status;
    return data;
  }

  NotificationModel copyWith({int? id, String? photo, String? name, String? desc, String? status}) {
    return NotificationModel(id: id ?? this.id, photo: photo ?? this.photo, name: name ?? this.name, desc: desc ?? this.desc, status: status ?? this.status);
  }
}
