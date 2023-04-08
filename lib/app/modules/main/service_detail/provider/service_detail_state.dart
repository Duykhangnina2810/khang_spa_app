// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServiceDetailState {
  int selectedId;
  ServiceDetailState({
    required this.selectedId,
  });

  ServiceDetailState copyWith({
    int? selectedId,
  }) {
    return ServiceDetailState(
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
