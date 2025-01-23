import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/navigation/routes.dart';
import 'package:bite/ui/components/communications/progress_indicator.dart';
import 'package:bite/ui/scene/base_page_screen/base_page_screen.dart';
import 'package:bite/ui/components/actions/common_buttons/filled_button.dart';
import 'package:bite/ui/components/actions/common_buttons/outlined_button.dart';
import 'package:bite/ui/components/app_bar/app_bar.dart';
import 'package:bite/ui/components/selection/choice_chips.dart';
import 'package:bite/ui/components/text/text_body_b1.dart';
import 'package:bite/ui/components/text/text_title_h1.dart';
import 'package:bite/ui/scene/poi_detail_from_beacon/bloc/poi_detail_from_beacon_cubit.dart';
import 'package:bite/ui/scene/poi_detail_from_beacon/bloc/poi_detail_from_beacon_state.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:bite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PoiDetailFromBeaconScreen extends BasePageScreen {
  const PoiDetailFromBeaconScreen({super.key});

  @override
  State<PoiDetailFromBeaconScreen> createState() =>
      _PoiDetailFromBeaconScreenState();
}

class _PoiDetailFromBeaconScreenState extends State<PoiDetailFromBeaconScreen> {
  String? externalId;
  int carouselPosition = 0;

  String _buildOpeningHoursText(PoiDetail? poiDetail) {
    if (poiDetail == null) {
      return '-';
    }

    final List<String> openingHours = [];

    if (poiDetail.openingHours != null) {
      final openingHoursMap = {
        'Lunedì': poiDetail.openingHours!.monday,
        'Martedì': poiDetail.openingHours!.tuesday,
        'Mercoledì': poiDetail.openingHours!.wednesday,
        'Giovedì': poiDetail.openingHours!.thursday,
        'Venerdì': poiDetail.openingHours!.friday,
        'Sabato': poiDetail.openingHours!.saturday,
        'Domenica': poiDetail.openingHours!.sunday,
      };

      for (final day in openingHoursMap.keys) {
        final intervals = openingHoursMap[day];
        if (intervals != null && intervals.isNotEmpty) {
          final intervalStrings = intervals
              .map((interval) => '${interval.from} - ${interval.to}')
              .join(', ');
          openingHours.add('$day: $intervalStrings');
        }
      }
    }

    return openingHours.isNotEmpty ? openingHours.join('\n') : '-';
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? extraParams =
        GoRouterState.of(context).extra as Map<String, dynamic>?;
    if (extraParams != null) {
      externalId = extraParams['externalId'] as String?;
    }

    return Container(
      color: BiteColors.bgColor,
      child: BlocProvider(
        create: (context) => PoiDetailFromBeaconCubit(externalId ?? ''),
        child: BlocListener<PoiDetailFromBeaconCubit, PoiDetailFromBeaconState>(
          listener: (context, state) {
            if (state is PoiDetailFromBeaconScanDisposed) {
              context.pop(true);
            }

            if (state is PoiDetailFromBeaconError) {
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
          child:
              BlocBuilder<PoiDetailFromBeaconCubit, PoiDetailFromBeaconState>(
            builder: (context, state) {
              PoiDetail? poiDetail;

              // Cubit instance
              final cubit = context.read<PoiDetailFromBeaconCubit>();

              if (state is PoiDetailFromBeaconLoading) {
                return const Center(
                  child: BiteProgressIndicator(
                    type: BiteProgressIndicatorType.circular,
                  ),
                );
              }

              if (state is PoiDetailFromBeaconError) {
                return const Center(
                  child: SizedBox(),
                );
              }

              if (state is PoiDetailFromBeaconSuccess) {
                poiDetail = state.poiDetail;
              }

              return Scaffold(
                appBar: BiteAppBar(
                  backgroundColor: BiteColors.bgColor,
                  title: poiDetail?.name ?? '',
                  onIconTap: () {
                    cubit.disposeScan();
                  },
                ),
                body: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 211,
                          child: Stack(
                            children: [
                              poiDetail?.media?.isNotEmpty == true
                                  ? PageView.builder(
                                      itemCount: poiDetail?.media?.length ?? 0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context,
                                          int pagePosition) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 1),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            child: AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: Image.network(
                                                poiDetail?.media?[
                                                        pagePosition] ??
                                                    '',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      onPageChanged: (pageposition) {
                                        setState(() {
                                          carouselPosition = pageposition;
                                        });
                                      },
                                    )
                                  : Center(
                                      child: Image.asset(
                                        'assets/images/black_logo.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              Positioned(
                                bottom: 15,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 48,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          for (var i = 0;
                                              i <
                                                  (poiDetail?.media?.length ??
                                                      0);
                                              i++)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6),
                                              child: SizedBox(
                                                width: i == carouselPosition
                                                    ? 16
                                                    : 8.0,
                                                height: 8.0,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: i == carouselPosition
                                                        ? BiteColors
                                                            .primaryColor
                                                        : BiteColors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BiteChip(
                                label: state is PoiDetailFromBeaconSuccess &&
                                        state.poiAffluence != null &&
                                        state.poiAffluence != 0
                                    ? state.poiAffluence.toString()
                                    : '-',
                                prefixIconName: 'icon_partner_exchange',
                                isLoading: context
                                        .read<PoiDetailFromBeaconCubit>()
                                        .poiAffluence ==
                                    null,
                              ),
                              BiteChip(
                                label: context
                                    .read<PoiDetailFromBeaconCubit>()
                                    .temperature,
                                prefixIconName: 'icon_thermostat',
                                isLoading: context
                                        .read<PoiDetailFromBeaconCubit>()
                                        .temperature ==
                                    null,
                              ),
                              BiteChip(
                                label: context
                                    .read<PoiDetailFromBeaconCubit>()
                                    .humidity
                                    .toString(),
                                prefixIconName: 'icon_humidity_percentage',
                                isLoading: context
                                        .read<PoiDetailFromBeaconCubit>()
                                        .humidity ==
                                    null,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // POI name
                              BiteTitleH1Text(
                                text: poiDetail?.name ?? '-',
                              ),
                              BiteBodyB1Text(
                                text: poiDetail?.address ?? '-',
                              ),
                            ],
                          ),
                        ),
                        // Services
                        if (poiDetail?.services?.isNotEmpty == true) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BiteTitleH1Text(
                                    text: context.l10n!.availableServices,
                                  ),
                                  BiteBodyB1Text(
                                    text:
                                        poiDetail?.services?.join(", ") ?? '-',
                                  ),
                                ]),
                          ),
                        ],
                        // Opening hours
                        if (poiDetail?.openingHours != null) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BiteTitleH1Text(
                                  text: context.l10n!.openingHours,
                                ),
                                BiteBodyB1Text(
                                  text: _buildOpeningHoursText(poiDetail),
                                ),
                              ],
                            ),
                          ),
                        ],
                        // Description
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BiteTitleH1Text(
                                  text: context.l10n!.descriptionLabel,
                                ),
                                BiteBodyB1Text(
                                  text: poiDetail?.description ?? '-',
                                ),
                              ]),
                        ),
                        // Go to route button
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Column(
                            children: [
                              BiteOutlinedButton(
                                onPressed: () {},
                                width: double.maxFinite,
                                text: context.l10n!.goToRoute,
                                prefixIconName: 'icon_routes',
                                leftTextPadding: 10,
                                rightTextPadding: 10,
                                topTextPadding: 10,
                                bottomTextPadding: 10,
                                borderRadius: 16,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              // Report button
                              BiteFilledButton(
                                onPressed: () {
                                  context.push(Routes.reportScreen, extra: {
                                    'poiId': poiDetail?.id,
                                  });
                                },
                                width: double.maxFinite,
                                text: context.l10n!.reportScreen,
                                prefixIconColor: BiteColors.black,
                                prefixIconName: 'icon_report',
                                leftPadding: 10,
                                rightPadding: 10,
                                topPadding: 10,
                                bottomPadding: 10,
                                borderRadius: 16,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
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
