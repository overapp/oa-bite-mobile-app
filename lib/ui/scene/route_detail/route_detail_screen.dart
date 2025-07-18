import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/models/responses/location/location.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/models/screen/poi_detail/screen_type.dart';
import 'package:bite/navigation/routes.dart';
import 'package:bite/ui/components/actions/common_buttons/filled_button.dart';
import 'package:bite/ui/components/app_bar/app_bar.dart';
import 'package:bite/ui/components/communications/progress_indicator.dart';
import 'package:bite/ui/components/text/text_body_b1.dart';
import 'package:bite/ui/components/text/text_title_h1.dart';
import 'package:bite/ui/scene/route_detail/bloc/route_detail_cubit.dart';
import 'package:bite/ui/scene/route_detail/bloc/route_detail_state.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:bite/ui/themes/bite_text.dart';
import 'package:bite/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDetailScreen extends StatefulWidget {
  const RouteDetailScreen({super.key});

  @override
  State<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  RouteDetail? detail;

  void visitPoi(BuildContext context, String poiId, Location poiLocation) {
    showBiteDialog(
        context, 'icon_waypoints', context.l10n?.vistPoiQuestion ?? '', '',
        action1Message: context.l10n?.goToRouteLabel ?? '',
        onAction1Tap: () async {
          Navigator.of(context).pop();
          // close the bottom sheet
          Navigator.of(context).pop();

          await context.read<RouteDetailCubit>().visitedPoi(
                poiId,
              );
          launchMap(
            poiLocation.latitude,
            poiLocation.longitude,
          );
        },
        action2Message: context.l10n?.dontVisit ?? '',
        onAction2Tap: () async {
          Navigator.of(context).pop();
          // close the bottom sheet
          Navigator.of(context).pop();
          await context.read<RouteDetailCubit>().discardedPoi(
                poiId,
              );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? extraParams =
        GoRouterState.of(context).extra as Map<String, dynamic>?;
    if (extraParams != null) {
      detail = extraParams['detail'] as RouteDetail?;
    }
    return Scaffold(
      backgroundColor: BiteColors.bgColor,
      body: BlocProvider(
        create: (context) => RouteDetailCubit(
          detail ??
              const RouteDetail(
                id: 'id',
                name: 'name',
                category: RouteCategory.undefined,
                availableServices: [],
              ),
        ),
        child: BlocListener<RouteDetailCubit, RouteDetailState>(
          listener: (context, state) {
            context.read<RouteDetailCubit>();

            if (state is RouteDetailShowBottomSheet) {
              Location poiLocation =
                  getTappedPoiCordinates(state.detail, state.tappedPoiId ?? '');

              startRouteBottomSheet(
                context: context,
                onCardTap: (id) {
                  visitPoi(context, id, poiLocation);
                },
                pois: state.detail.stops ?? [],
                visitedPois: state.activeRoute?.pois,
                suggestedPoi: state.suggestedPoi?.id ?? '',
              );
            }

            if (state is RouteDetailExistingRoute) {
              showBiteDialog(
                  context,
                  'icon_waypoints',
                  context.l10n?.alreadyActiveRoute ?? '',
                  context.l10n?.alreadyActiveRouteMessage ?? '',
                  action1Message: context.l10n?.startNewRoute ?? '',
                  onAction1Tap: () async {
                    Navigator.of(context).pop();

                    await context
                        .read<RouteDetailCubit>()
                        .deleteAndActivateNewRoute(
                            state.detail.id, state.detail.name);
                    // launchMap(
                    //   state.suggestedPoi?.location?.latitude ?? 90,
                    //   state.suggestedPoi?.location?.longitude ?? 90,
                    // );
                  },
                  action2Message: context.l10n?.cancelLabel ?? '',
                  onAction2Tap: () async {
                    Navigator.of(context).pop();
                  });
            }

            if (state is RouteDetailCompleted) {
              showBiteDialog(context, 'icon_waypoints',
                  context.l10n?.completeRoute ?? '', state.detail.name,
                  action1Message: context.l10n?.okLabel ?? '',
                  onAction1Tap: () {
                context.pop();
                context.pop();
              });
            }
          },
          child: BlocBuilder<RouteDetailCubit, RouteDetailState>(
            builder: (context, state) {
              if (state is RouteDetailLoading) {
                return const Column(
                  children: [
                    Center(
                      child: BiteProgressIndicator(
                        type: BiteProgressIndicatorType.circular,
                      ),
                    ),
                  ],
                );
              }

              final cubit = context.read<RouteDetailCubit>();

              // Set Marker for each POI
              final Set<Marker> markers = detail?.path?.map((poi) {
                    return Marker(
                      icon: cubit.markerIcon ?? BitmapDescriptor.defaultMarker,
                      markerId: MarkerId('${poi.latitude} ${poi.longitude}'),
                      position: LatLng(
                        poi.latitude,
                        poi.longitude,
                      ),
                      onTap: () {},
                    );
                  }).toSet() ??
                  {};

              Set<Polyline> polylines = cubit.polylines;

              return Scaffold(
                appBar: BiteAppBar(
                  backgroundColor: BiteColors.bgColor,
                  title: detail?.name ?? '',
                  onIconTap: () {
                    context.pop(true);
                  },
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  (28 / 100),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: GoogleMap(
                                  mapType: MapType.satellite,
                                  initialCameraPosition: CameraPosition(
                                    target: cubit.currentPosition ??
                                        LatLng(
                                          detail?.path?.first.latitude ?? 90,
                                          detail?.path?.first.longitude ?? 90,
                                        ),
                                    zoom: 14,
                                  ),
                                  onMapCreated: (controller) {
                                    cubit.setMapController(controller);
                                  },
                                  indoorViewEnabled: false,
                                  markers: markers,
                                  polylines: polylines,
                                  compassEnabled: false,
                                  myLocationButtonEnabled: false,
                                  mapToolbarEnabled: false,
                                  rotateGesturesEnabled: false,
                                  scrollGesturesEnabled: true,
                                  trafficEnabled: false,
                                  onTap: null,
                                  onCameraIdle: null,
                                  onCameraMove: null,
                                  onCameraMoveStarted: null,
                                  onLongPress: null,
                                  buildingsEnabled: true,
                                  myLocationEnabled: true,
                                  tiltGesturesEnabled: false,
                                  zoomControlsEnabled: false,
                                  gestureRecognizers: {}..add(
                                      Factory<PanGestureRecognizer>(
                                          () => PanGestureRecognizer())),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 24,
                        ),
                        RichText(
                          text: TextSpan(
                            text: context.l10n!.departureLabel,
                            style: const TextStyle(
                              color: BiteColors.textColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Urbanist',
                            ),
                            children: [
                              const WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4),
                                ),
                              ),
                              // Starting address of the route
                              TextSpan(
                                text: '-',
                                style: biteTextTheme.bodyMedium!
                                    .apply(color: BiteColors.textColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        RichText(
                          text: TextSpan(
                            text: context.l10n!.arriveLabel,
                            style: const TextStyle(
                              color: BiteColors.textColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Urbanist',
                            ),
                            children: [
                              const WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4),
                                ),
                              ),
                              // End address
                              TextSpan(
                                text: '-',
                                style: biteTextTheme.bodyMedium!.apply(
                                  color: BiteColors.textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // Services title
                        BiteTitleH1Text(
                          text: context.l10n!.availableServices,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        // Services
                        BiteBodyB1Text(
                          text: (detail?.availableServices.isNotEmpty ?? false)
                              ? detail!.availableServices
                                  .map((service) => service.name)
                                  .join(", ")
                              : '-',
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // Points of interest title
                        BiteTitleH1Text(
                          text: context.l10n!.pointsOfInterestLabel,
                        ),
                        if (detail?.stops != null) ...[
                          // Points of interest bulleted list
                          for (var poi in detail!.stops!)
                            GestureDetector(
                              onTap: () {
                                context.push(Routes.poiDetailScreen, extra: {
                                  'poiId': poi.poiId,
                                  'screenType': PoiDetailScreenType.fromMap
                                });
                              },
                              child: Row(
                                children: [
                                  BiteBodyB1Text(
                                      text: '${(poi.order ?? 0) + 1}.'),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  BiteBodyB1Text(
                                    text: poi.poiId ?? '',
                                    underlined: true,
                                  )
                                ],
                              ),
                            ),
                        ],
                        const SizedBox(
                          height: 24,
                        ),
                        BiteTitleH1Text(
                          text: context.l10n!.descriptionLabel,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        // Description
                        BiteBodyB1Text(
                          text: detail?.description ?? '',
                        ),

                        const SizedBox(
                          height: 48,
                        ),

                        BiteFilledButton(
                          bottomPadding: 8,
                          topPadding: 8,
                          onPressed: cubit.currentPosition != null
                              ? () async {
                                  // Save in shared preferences id of route
                                  cubit.activateRoute(
                                      detail?.id ?? '', detail?.name ?? '');
                                }
                              : null,
                          text: context.l10n!.startRoute,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
