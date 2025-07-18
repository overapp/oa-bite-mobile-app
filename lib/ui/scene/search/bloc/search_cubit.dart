import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/pois_by_beacon_coordinates/pois_by_beacon_coordinates.dart';
import 'package:bite/repository/manager/repo_manager/repository_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bite/ui/scene/search/bloc/search_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(String? searchTerm, double latitude, double longitude)
      : super(SearchInitial(
            searchTerm: searchTerm, latitude: latitude, longitude: longitude)) {
    init(searchTerm);
  }

  final PagingController<int, PoiDetail> pagingController =
      PagingController(firstPageKey: 1);

  // Total items for search results

  final int _pageSize = 10;
  int currentPage = 1;
  String searchedText = '';

  // Search Results
  PoisByBeaconCoordinates? searchResults;

  void init(
    String? searchTerm,
  ) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(state.latitude ?? 90, state.longitude ?? 90, searchTerm, 1);
    });
  }

  void updateCurrentPage(int index, String query) {
    currentPage = index;
    searchedText = query;
  }

  // Infinite scroll
  Future<void> _fetchPage(
    double latitude,
    double longitude,
    String? searchTerm,
    int pageKey,
  ) async {
    emit(SearchLoading(
      searchTerm: state.searchTerm,
      latitude: state.latitude,
      longitude: state.longitude,
    ));

    await RepoManager().manager.getPoisByCoordinates(
      latitude,
      longitude,
      searchTerm,
      pageKey,
      _pageSize,
      (PoisByBeaconCoordinates data) {
        final isLastPage = (data.items.length) < _pageSize;

        searchResults = data;

        if (isLastPage == true) {
          pagingController.appendLastPage(data.items);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(data.items, nextPageKey);
        }
        emit(SearchSuccess(
          searchTerm: state.searchTerm,
          latitude: state.latitude,
          longitude: state.longitude,
        ));
      },
      (typeDataError, status, message) {
        emit(SearchError(
          searchTerm: state.searchTerm,
          latitude: state.latitude,
          longitude: state.longitude,
        ));
        pagingController.error = 'error:  $message';
      },
    );
  }

  // API calls

  Future<void> fullTextSearch(
      String? searchTerm, int page, double latitude, double longitude) async {
    pagingController.itemList = [];
    searchedText = searchTerm ?? '';
    currentPage = 1;

    await _fetchPage(latitude, longitude, searchTerm, page);
  }
}
