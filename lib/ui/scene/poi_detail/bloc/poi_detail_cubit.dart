import 'package:bite/models/responses/location/location.dart';
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/poi/poi_affluence/poi_affluence.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/repository/manager/repo_manager/repository_manager.dart';
import 'package:bite/ui/scene/poi_detail/bloc/poi_detail_state.dart';
import 'package:bite/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PoiDetailCubit extends Cubit<PoiDetailState> {
  PoiDetailCubit(
    String poiId,
  ) : super(PoiDetailInitial(poiId: poiId)) {
    getPoiById(poiId);
  }

// API responses
  PoiDetail? poiDetail;
  int? poiAffluence;

// API calls

  // Get POI by id
  Future<void> getPoiById(String poiId) async {
    emit(PoiDetailLoading(poiId: state.poiId));
    await RepoManager().manager.getPoiById(
      poiId,
      (PoiDetail data) {
        poiDetail = data;
        BiteLogger().info('POI detail: $poiId: $data');

        emit(PoiDetailSuccess(
          poiId: state.poiId,
          poiDetail: data,
        ));

        Future.delayed(const Duration(seconds: 3), () {
          getPoiAffluence(poiId);
        });
      },
      (String status, String message) {
        emit(PoiDetailError(
          poiId: state.poiId,
          message: 'error: $status $message',
        ));
      },
    );
  }

  // Get POI affluence
  Future<void> getPoiAffluence(String poiId) async {
    await RepoManager().manager.getPoiAffluence(
      poiId,
      (PoiAffluence data) {
        BiteLogger().info('Traffic: $poiId: $data');

        emit(
          PoiDetailSuccess(
              poiId: state.poiId,
              poiDetail: poiDetail ??
                  const PoiDetail(
                    id: 'id',
                    name: 'name',
                    beaconId: 'beaconId',
                    location: Location(longitude: 90, latitude: 90),
                  ),
              poiAffluence: data.value),
        );
      },
      (String status, String message) {
        poiAffluence = 0;
      },
    );
  }

// Get Route by POI id
  Future<void> getRoutebyId(
    String poiId,
  ) async {
    emit(PoiDetailLoading(poiId: state.poiId));
    await RepoManager().manager.getRoutebyPoiId(
      poiId,
      (RouteDetail data) {
        BiteLogger().info('Route by POI  $data');

        emit(PoiDetailGetRouteById(
          poiId: state.poiId,
          routeDetail: data,
        ));
      },
      (String status, String message) {
        emit(PoiDetailError(
          poiId: state.poiId,
          message: 'error: $status $message',
        ));
      },
    );
  }
}
