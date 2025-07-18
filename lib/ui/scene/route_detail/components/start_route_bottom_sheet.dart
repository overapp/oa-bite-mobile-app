import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/models/responses/route/poi_info/poi_info.dart';
import 'package:bite/models/shared_preferences/active_route/active_route.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_title_h1.dart';
import 'package:bite/ui/scene/route_detail/components/poi_card.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class StartRouteBottomSheet extends StatelessWidget {
  final void Function(String id) onCardTapped;
  final List<PoiInfo> pois;
  final List<PoiShortInfo>? visitedPois;
  final String suggestedPoi;

  const StartRouteBottomSheet(
      {super.key,
      required this.onCardTapped,
      required this.pois,
      this.visitedPois,
      required this.suggestedPoi});

  PoiStatus _getPoiStatus(List<PoiShortInfo> pois, PoiInfo poi) {
    final currentPoi = pois.firstWhereOrNull(
      (p) => p.poiId == poi.poiId,
    );

    switch (currentPoi?.status) {
      case ActiveRoutePoiStatus.visited:
      case ActiveRoutePoiStatus.toAvoid:
        return PoiStatus.visited;
      case ActiveRoutePoiStatus.toVisit:
        return PoiStatus.available;
      case ActiveRoutePoiStatus.inVisit:
        return PoiStatus.selected;
      case null:
        return PoiStatus.available;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BiteTitleH1Text(
                text: context.l10n?.activateRoute ?? '',
                textAlign: TextAlign.start,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const BiteIcon(
                  iconName: 'icon_close_small',
                  height: 32,
                  width: 32,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          for (var poi in pois)
            Builder(
              builder: (_) {
                final status = _getPoiStatus(visitedPois ?? [], poi);
                return PoiCard(
                  poiAddress: poi.shortDescription ?? '',
                  poiName: '${(poi.name ?? '').toUpperCase()} - ${poi.address ?? ''}',
                  status: status,
                  isSuggested: poi.poiId == suggestedPoi,
                  onCardTap: status == PoiStatus.visited
                      ? null
                      : () {
                          onCardTapped(poi.poiId ?? '');
                        },
                );
              },
            ),
        ],
      ),
    );
  }
}
