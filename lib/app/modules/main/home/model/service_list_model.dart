// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServiceListModel {
  late String namevi;
  late int id;

  ServiceListModel({this.namevi = '', this.id = 0});

  ServiceListModel.fromJson(Map<String, dynamic> json) {
    namevi = json['namevi'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['namevi'] = namevi;
    data['id'] = id;
    return data;
  }

  ServiceListModel copyWith({String? namevi, int? id}) {
    return ServiceListModel(namevi: namevi ?? this.namevi, id: id ?? this.id);
  }
}
