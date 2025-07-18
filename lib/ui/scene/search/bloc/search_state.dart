abstract class SearchState {
  final String? searchTerm;
  final double? latitude;
  final double? longitude;

  SearchState({
    required this.searchTerm,
    required this.latitude,
    required this.longitude,
  });
}

class SearchInitial extends SearchState {
  SearchInitial(
      {required super.searchTerm,
      required super.latitude,
      required super.longitude});
}

class SearchLoading extends SearchState {
  SearchLoading(
      {required super.searchTerm,
      required super.latitude,
      required super.longitude});
}

class SearchSuccess extends SearchState {
  SearchSuccess(
      {required super.searchTerm,
      required super.latitude,
      required super.longitude});
}

class SearchError extends SearchState {
  SearchError(
      {required super.searchTerm,
      required super.latitude,
      required super.longitude});
}
