import 'package:bite/ui/components/text/text_body_chips.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

enum PoiStatus {
  visited,
  selected,
  available,
}

class PoiCard extends StatelessWidget {
  final String poiName;
  final String poiAddress;
  final PoiStatus status;
  final Function? onCardTap;
  final bool isSuggested;

  const PoiCard({
    super.key,
    required this.poiName,
    required this.poiAddress,
    required this.status,
    this.onCardTap,
    required this.isSuggested,
  });

  Color _getBgColor() {
    switch (status) {
      case PoiStatus.visited:
        return BiteColors.bgDisabledColor;
      case PoiStatus.selected:
        return BiteColors.primaryColor;
      case PoiStatus.available:
        return BiteColors.bgColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap != null ? () => onCardTap!() : null,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: _getBgColor(),
              border: Border.all(color: _getBgColor()),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BiteBodyChipsText(
                        text: poiName,
                        overflow: TextOverflow.ellipsis,
                      ),
                      BiteBodyChipsText(
                        text: poiAddress,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (status == PoiStatus.selected || isSuggested)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: BiteColors.primaryColor.withValues(alpha: 0.8),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
