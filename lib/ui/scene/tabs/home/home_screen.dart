import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/navigation/routes.dart';
import 'package:bite/ui/components/actions/common_buttons/filled_button.dart';
import 'package:bite/ui/components/containers/search_result_card.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_button_bold.dart';
import 'package:bite/ui/components/text/text_title_h1.dart';
import 'package:bite/ui/components/text_inputs/search_bar.dart';
import 'package:bite/ui/scene/base_page_screen/base_page_screen.dart';
import 'package:bite/ui/scene/tabs/home/bloc/home_cubit.dart';
import 'package:bite/ui/scene/tabs/home/bloc/home_state.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:bite/utils/logger.dart';
import 'package:bite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends BasePageScreen {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BasePageScreenState<HomeScreen> {
  @override
  Widget buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              // Error state dialog
              showBiteDialog(
                context,
                'icon_close',
                context.l10n!.errorTitle,
                context.l10n!.genericError,
                action2Message: context.l10n!.okLabel,
                onAction2Tap: () {
                  Navigator.of(context).pop();
                },
              );
            }
          },
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomePermissionDenied) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: BiteColors.bgDisabledColor),
                        margin: const EdgeInsets.only(top: 24),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const BiteIcon(iconName: 'icon_search'),
                            const SizedBox(
                              width: 16,
                            ),
                            BiteButtonBoldText(
                              text: context.l10n!.searchPOI,
                              textColor: BiteColors.bgCardsColor,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const BiteIcon(iconName: 'icon_close'),
                      const SizedBox(
                        height: 24,
                      ),
                      BiteTitleH1Text(
                        text: context.l10n!.pemissionDeniedLabel,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 6),
                        child: BiteFilledButton(
                            width: double.maxFinite,
                            topPadding: 8,
                            bottomPadding: 8,
                            leftPadding: 16,
                            rightPadding: 16,
                            onPressed: () {
                              openAppSettings();
                            },
                            text: context.l10n!.goToSettings),
                      ),
                      const Spacer()
                    ],
                  ),
                );
              }

              // Home Cubit
              final homeCubit = context.read<HomeCubit>();

              // Set Marker for each POI
              final Set<Marker> markers = state is HomeSuccess
                  ? context
                          .read<HomeCubit>()
                          .poisByBeaconCoordinates
                          ?.items
                          .map((poi) {
                        return Marker(
                          icon: homeCubit.markerIcon ??
                              BitmapDescriptor.defaultMarker,
                          markerId: MarkerId(poi.id),
                          position: LatLng(
                            poi.location.latitude,
                            poi.location.longitude,
                          ),
                          onTap: () {
                            context.push(Routes.poiDetail, extra: {
                              'poiId': poi.id,
                            });
                          },
                        );
                      }).toSet() ??
                      {}
                  : {};

              return Stack(
                children: [
                  // Google Maps widget
                  Positioned.fill(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target:
                            homeCubit.currentPosition ?? const LatLng(90, 90),
                        zoom: 15,
                      ),
                      onMapCreated: (controller) {
                        homeCubit.setMapController(controller);
                      },
                      onTap: (argument) {},
                      onCameraIdle: () {},
                      onCameraMoveStarted: () {},
                      compassEnabled: false,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      markers: markers,
                      mapType: MapType.normal,
                    ),
                  ),
                  //Search Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: BiteSearchBar<PoiDetail>(
                            hintText: context.l10n?.searchPOI ?? '',
                            showMore:
                                homeCubit.searchResults?.hasNextPage ?? false,
                            displayStringForOption: (item) => item.name,
                            resultBuilder: (item) => SearchResultCard(
                              result: item,
                              isLastElement: false,
                            ),
                            onShowMoreTapped: () {
                              if (homeCubit.searchResults?.hasNextPage ??
                                  false) {
                                homeCubit.fullTextSearch(
                                  homeCubit.currentPosition?.latitude ?? 90,
                                  homeCubit.currentPosition?.longitude ?? 90,
                                  homeCubit.searchedText,
                                  homeCubit.currentPage + 1,
                                );
                              }
                            },
                            fetchOptions: (String query) async {
                              if (query.length > 2) {
                                homeCubit.fullTextSearch(
                                  homeCubit.currentPosition?.latitude ?? 90,
                                  homeCubit.currentPosition?.longitude ?? 90,
                                  query,
                                  1,
                                );

                                homeCubit.updateCurrentPage(1, query);

                                return homeCubit.searchResults?.items ?? [];
                              } else {
                                return [];
                              }
                            },
                            onSelected: (selectedResult) {
                              final PoiDetail result = selectedResult;

                              context.push(Routes.poiDetail, extra: {
                                'poiId': result.id,
                              });

                              BiteLogger().info('Selected result: $result');
                            },
                          ),
                        ),
                        const SizedBox(height: 90),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
