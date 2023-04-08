// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../model/search_model.dart';

class SearchState {
  List<SearchModel> searchKeywords;
  SearchState({
    required this.searchKeywords,
  });

  SearchState copyWith({
    List<SearchModel>? searchKeywords,
  }) {
    return SearchState(
      searchKeywords: searchKeywords ?? this.searchKeywords,
    );
  }
}
