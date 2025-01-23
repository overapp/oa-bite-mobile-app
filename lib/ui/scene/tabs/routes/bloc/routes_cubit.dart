import 'package:bite/helpers/firebase_keys.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/models/responses/route/get_routes/get_routes.dart';
import 'package:bite/repository/manager/repo_manager/repository_manager.dart';
import 'package:bite/services/firebase/firebase_service.dart';
import 'package:bite/ui/scene/tabs/routes/bloc/routes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RoutesCubit extends Cubit<RoutesState> {
  RoutesCubit() : super(RoutesInitial()) {
    init();
  }

  // Main List Properties
  final PagingController<int, RouteDetail> pagingController =
      PagingController(firstPageKey: 1);

  final int _pageSize = 10;

  // API Response
  GetRoutes? routes;
  GetRoutes? filteredRoutes;

  // Total items for search results
  int? totalItems = 10;
  int currentPage = 1;
  String searchedText = '';

  // Remote Config
  final remoteConfig = FirebaseRemoteConfigService();

  bool _isInitialized = false;

  void init() {
    if (_isInitialized) {
      return;
    }

    _isInitialized = true;

    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(null, null, 1, pageKey);
    });

    _getFullTextTotalCount();
  }

  void _getFullTextTotalCount() {
    totalItems =
        remoteConfig.getInt(FirebaseRemoteConfigKeys.fullTextSearchTotalCount);
  }

  void updateCurrentPage(int index, String query) {
    currentPage = index;
    searchedText = query;
  }

  // Infinite scroll
  Future<void> _fetchPage(
    String? searchTerm,
    String? sortBy,
    int direction,
    int pageKey,
  ) async {
    emit(RoutesLoading());

    await RepoManager().manager.getRoutes(
      searchTerm,
      sortBy,
      direction,
      pageKey,
      _pageSize,
      (GetRoutes data) {
        final isLastPage = (data.items.length) < _pageSize;

        routes = data;

        if (isLastPage == true) {
          pagingController.appendLastPage(data.items);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(data.items, nextPageKey);
        }
        emit(RoutesSuccess(routes: data));
      },
      (String message) {
        emit(RoutesError(message: 'error: $message'));
        pagingController.error = 'error:  $message';
      },
    );
  }

  // API calls

  Future<void> fullTextSearch(String? searchTerm, int page) async {
    if (!_isInitialized) {
      init();
    }

    pagingController.itemList = [];
    searchedText = searchTerm ?? '';
    currentPage = 1;

    await _fetchPage(searchTerm, null, 1, page);
  }
}
