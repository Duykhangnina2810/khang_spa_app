class SlideModel {
  late String namevi;
  late String photo;

  SlideModel({this.namevi = "", this.photo = ""});

  SlideModel.fromJson(Map<String, dynamic> json) {
    namevi = json['namevi'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['namevi'] = namevi;
    data['photo'] = photo;
    return data;
  }
}
