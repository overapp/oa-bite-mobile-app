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

  String _getIcon(String category) {
    switch (category.toLowerCase()) {
      case 'archeology':
        return 'icon_archeology';
      case 'monuments':
        return 'icon_monuments';
      case 'tradition':
        return 'icon_tradition';
      case 'trekking':
        return 'icon_trekking';
      case 'undefined':
      default:
        return 'icon_waypoints';
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
                  iconName: _getIcon(detail?.category ?? ''),
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
              BiteBodyB2Text(text: detail?.category ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
