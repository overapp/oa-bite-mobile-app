import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/ui/components/dividers/horizontal_dividers.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_button_bold.dart';
import 'package:bite/ui/components/text/text_button_regular.dart';
import 'package:flutter/material.dart';

class SearchResultCard extends StatelessWidget {
  final PoiDetail result;
  final bool isLastElement;

  const SearchResultCard({
    super.key,
    required this.result,
    required this.isLastElement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const BiteIcon(
                  iconName: 'icon_pin_location',
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BiteButtonBoldText(
                        text: result.name,
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
        ),
        if (!isLastElement) ...[
          const BiteHorizontalDivider(
            verticalPadding: 16,
            height: 0,
            thickness: 1,
          ),
        ] else if (isLastElement) ...[
          const SizedBox(
            height: 16,
          ),
        ]
      ],
    );
  }
}
