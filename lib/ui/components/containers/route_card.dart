import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_body_b2.dart';
import 'package:bite/ui/components/text/text_title_h1.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class RouteCard extends StatelessWidget {
  final Function(RouteDetail? item) onCardTap;
  final RouteDetail? detail;
  final double leftMargin;
  final double rightMargin;

  const RouteCard({
    super.key,
    required this.onCardTap,
    required this.detail,
    this.leftMargin = 0,
    this.rightMargin = 0,
  });

  String _getIcon(RouteCategory category) {
    switch (category) {
      case RouteCategory.archeology:
        return 'icon_archeology';
      case RouteCategory.monuments:
        return 'icon_monuments';
      case RouteCategory.tradition:
        return 'icon_tradition';
      case RouteCategory.trekking:
        return 'icon_trekking';
      case RouteCategory.undefined:
        return 'icon_waypoints';
    }
  }

  String _getCategory(RouteCategory category, BuildContext context) {
    switch (category) {
      case RouteCategory.archeology:
        return context.l10n!.archeology;
      case RouteCategory.monuments:
        return context.l10n!.monuments;
      case RouteCategory.tradition:
        return context.l10n!.tradition;
      case RouteCategory.trekking:
        return context.l10n!.trekking;
      case RouteCategory.undefined:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCardTap(detail);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(leftMargin, 0, rightMargin, 8),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: BiteColors.bgCardsColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0026FF).withAlpha(60),
              offset: const Offset(
                0,
                5,
              ),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              if (detail?.category != null) ...[
                BiteIcon(
                  iconName: _getIcon(detail!.category),
                ),
              ],
              const SizedBox(
                height: 24,
              ),
              BiteTitleH1Text(
                text: detail?.name ?? '',
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              if (detail?.category != null) ...[
                BiteBodyB2Text(
                  text: _getCategory(detail!.category, context),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
