import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/models/responses/location/location.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/models/shared_preferences/active_route/active_route.dart';
import 'package:bite/navigation/routes.dart';
import 'package:bite/ui/components/communications/progress_indicator.dart';
import 'package:bite/ui/components/containers/route_card.dart';
import 'package:bite/ui/components/text/text_button_regular.dart';
import 'package:bite/ui/scene/base_page_screen/base_page_screen.dart';
import 'package:bite/ui/scene/report_screen/bloc/report_state.dart';
import 'package:bite/ui/scene/tabs/routes/components/active_route_card.dart';
import 'package:bite/ui/scene/tabs/routes/components/search_bar.dart';
import 'package:bite/ui/scene/tabs/routes/bloc/routes_cubit.dart';
import 'package:bite/ui/scene/tabs/routes/bloc/routes_state.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:bite/ui/themes/bite_text.dart';
import 'package:bite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RoutesScreen extends BasePageScreen {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends BasePageScreenState<RoutesScreen> {
  TextEditingController searchBarController = TextEditingController();

  void visitPoi(
    BuildContext context,
    String poiId,
  ) {
    Location tappedPoiCordinates =
        context.read<RoutesCubit>().getTappedPoiCordinates(poiId);

    showBiteDialog(
        context, 'icon_waypoints', context.l10n?.vistPoiQuestion ?? '', '',
        action1Message: context.l10n?.goToRouteLabel ?? '',
        onAction1Tap: () async {
          Navigator.of(context).pop();
          // close the bottom sheet
          Navigator.of(context).pop();

          await context.read<RoutesCubit>().visitedPoi(
                poiId,
              );

          launchMap(
            tappedPoiCordinates.latitude,
            tappedPoiCordinates.longitude,
          );
        },
        action2Message: context.l10n?.dontVisit ?? '',
        onAction2Tap: () async {
          Navigator.of(context).pop();
          // close the bottom sheet
          Navigator.of(context).pop();
          await context.read<RoutesCubit>().discardedPoi(
                poiId,
              );
        });
  }

  List<String> getUnvisitedPois(ActiveRoute activeRoute) {
    return activeRoute.pois
        .where((e) =>
                e.status ==
                ActiveRoutePoiStatus
                    .toVisit /* ||
            e.status == ActiveRoutePoiStatus.toAvoid*/
            )
        .map((e) => e.poiId)
        .toList();
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => RoutesCubit(),
      child: Scaffold(
        body: BlocListener<RoutesCubit, RoutesState>(
          listener: (context, state) {
            if (state is RoutesShowBottomSheet) {
              startRouteBottomSheet(
                context: context,
                onCardTap: (id) {
                  visitPoi(context, id);
                },
                pois: state.pois ?? [],
                visitedPois: state.activeRoute?.pois,
                suggestedPoi: state.suggestedPoi?.id ?? '',
              );
            }

            if (state is RouteCompleted) {
              showBiteDialog(
                  context,
                  'icon_waypoints',
                  context.l10n?.alreadyActiveRoute ?? '',
                  context.l10n?.alreadyActiveRouteMessage ?? '',
                  action1Message: context.l10n?.startNewRoute ?? '',
                  onAction1Tap: () {
                context.pop();
              });
            }
          },
          child: BlocBuilder<RoutesCubit, RoutesState>(
            builder: (context, state) {
              final cubit = context.read<RoutesCubit>();

              if (state is ReportLoading) {
                return const Column(
                  children: [
                    Center(
                      child: BiteProgressIndicator(
                          type: BiteProgressIndicatorType.circular),
                    ),
                  ],
                );
              }

              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      child: BiteRoutesSearchBar(
                        controller: searchBarController,
                        hintText: context.l10n!.routesSearchBarHintText,
                        bgColor: BiteColors.primaryColor,
                        hintTextColor: BiteColors.textColor,
                        onChanged: (query) async {
                          if (query.length > 2) {
                            await cubit.fullTextSearch(
                              query,
                              1,
                            );

                            cubit.updateCurrentPage(1, query);
                          } else {
                            await cubit.fullTextSearch(
                              null,
                              1,
                            );
                          }
                        },
                      ),
                    ),
                    if ((state is RoutesGetActiveRoute ) &&
                        state.activeRoute != null )
                      ActiveRouteCard(
                        onCardTapped: () {
                          cubit.getNextPoi(
                              state.activeRoute!.routeId,
                              state.activeRoute!.pois
                                  .where((e) =>
                                          e.status ==
                                          ActiveRoutePoiStatus
                                              .toVisit /* ||
                                      e.status == ActiveRoutePoiStatus.toAvoid*/
                                      )
                                  .map((e) => e.poiId)
                                  .toList());
                        },
                        routeName: state.activeRoute!.routeName,
                        visitedPois: state.activeRoute!.pois
                            .where((e) =>
                                e.status == ActiveRoutePoiStatus.visited ||
                                e.status == ActiveRoutePoiStatus.toAvoid)
                            .length,
                      ),

                      
               
                    if (state is RoutesSuccess && state.activeRoute != null)
                      ActiveRouteCard(
                        onCardTapped: () {
                          cubit.getNextPoi(state.activeRoute!.routeId,
                              getUnvisitedPois(state.activeRoute!));
                        },
                        routeName: state.activeRoute!.routeName,
                        visitedPois: state.activeRoute!.pois
                            .where((e) =>
                                e.status == ActiveRoutePoiStatus.visited ||
                                e.status == ActiveRoutePoiStatus.toAvoid)
                            .length,
                      ),
                  
                    if (state is RoutesShowBottomSheet &&
                        state.activeRoute != null)
                      ActiveRouteCard(
                        onCardTapped: () {
                          cubit.getNextPoi(state.activeRoute!.routeId,
                              getUnvisitedPois(state.activeRoute!));
                        },
                        routeName: state.activeRoute!.routeName,
                        visitedPois: state.activeRoute!.pois
                            .where((e) =>
                                e.status == ActiveRoutePoiStatus.visited ||
                                e.status == ActiveRoutePoiStatus.toAvoid)
                            .length,
                      ),
                   
                    const SizedBox(height: 10),
                    if (state is RoutesSuccess)
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: RichText(
                            text: TextSpan(
                              text: state.routes.totalCount.toString(),
                              style: const TextStyle(
                                color: BiteColors.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Urbanist',
                              ),
                              children: [
                                const WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 4),
                                  ),
                                ),
                                TextSpan(
                                  text: context.l10n!.availableRoutes,
                                  style: biteTextTheme.bodySmall!
                                      .apply(color: BiteColors.textColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: PagedGridView<int, RouteDetail>(
                        shrinkWrap: true,
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
                        pagingController: cubit.pagingController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 8,
                          childAspectRatio: 2 / 3,
                        ),
                        builderDelegate: PagedChildBuilderDelegate<RouteDetail>(
                          itemBuilder: (context, item, index) {
                            return RouteCard(
                              detail: item,
                              leftMargin: index % 2 == 0 ? 24 : 0,
                              rightMargin: index % 2 != 0 ? 24 : 0,
                              onCardTap: (item) async {
                                final reloadscreen = await context
                                    .push(Routes.routeDetailScreen, extra: {
                                  'detail': item,
                                });

                                if (reloadscreen == true) {
                                  cubit.getActiveRoute(true, []);
                                }
                              },
                            );
                          },
                          noItemsFoundIndicatorBuilder: (context) => Center(
                            child: BiteButtonRegularText(
                              text: context.l10n!.noRoutesFound,
                            ),
                          ),
                          firstPageProgressIndicatorBuilder: (context) =>
                              const Center(
                                  child: BiteProgressIndicator(
                            type: BiteProgressIndicatorType.circular,
                          )),
                          newPageProgressIndicatorBuilder: (context) =>
                              const Center(
                                  child: BiteProgressIndicator(
                            type: BiteProgressIndicatorType.circular,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
