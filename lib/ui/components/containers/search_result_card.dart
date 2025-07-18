import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_button_bold.dart';
import 'package:bite/ui/components/text/text_button_regular.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class SearchResultCard extends StatelessWidget {
  final PoiDetail result;
  final bool isSearchScreen;
  final bool drawBottomBorder;

  const SearchResultCard({
    super.key,
    required this.result,
    this.isSearchScreen = false,
    this.drawBottomBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: isSearchScreen
                  ? BorderRadius.zero
                  : BorderRadius.circular(16),
              border: isSearchScreen
                  ? Border(
                      top: const BorderSide(color: BiteColors.primaryColor),
                      left: const BorderSide(color: BiteColors.primaryColor),
                      right: const BorderSide(color: BiteColors.primaryColor),
                      bottom: drawBottomBorder
                          ? const BorderSide(color: BiteColors.primaryColor)
                          : BorderSide.none,
                    )
                  : null),
          child: Row(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BiteIcon(
                iconName: 'icon_pin_location',
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BiteButtonBoldText(
                      text: result.name ?? '',
                    ),
                    if (result.address != null && result.address != '')
                      BiteButtonRegularText(
                        text: result.address!,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
