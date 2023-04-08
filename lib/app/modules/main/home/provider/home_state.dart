// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_example/app/modules/main/home/model/service_model.dart';

class ServiceListIdState {
  late int id;
  late int selectedIndex;
  ServiceListIdState({
    required this.id,
    required this.selectedIndex,
  });

  ServiceListIdState copyWith({
    int? id,
    int? selectedIndex,
  }) {
    return ServiceListIdState(
      id: id ?? this.id,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

class ServiceState {
  late List<ServiceModel> favorites;
  late String message;
  ServiceState({required this.favorites, required this.message});

  ServiceState copyWith({List<ServiceModel>? favorites, String? message}) {
    return ServiceState(favorites: favorites ?? this.favorites, message: message ?? this.message);
  }
}
