import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/ui/components/communications/progress_indicator.dart';
import 'package:bite/ui/components/containers/search_result_card.dart';
import 'package:bite/ui/components/dividers/horizontal_dividers.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_body_b1.dart';
import 'package:bite/ui/components/text/text_button_bold.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class BiteSearchBar extends StatefulWidget {
  final TextEditingController searchBarController;
  final Function(Object?) onSelected;
  final Function(String) suggestionsCallback;
  final bool hasNextPage;
  final Function onShowMoreTap;

  const BiteSearchBar({
    super.key,
    required this.searchBarController,
    required this.onSelected,
    required this.suggestionsCallback,
    required this.hasNextPage,
    required this.onShowMoreTap,
  });

  @override
  State<BiteSearchBar> createState() => _BiteSearchBarState();
}

class _BiteSearchBarState extends State<BiteSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      controller: widget.searchBarController,

      // Text Field Style
      builder: (context, controller, focusNode) => TextField(
        controller: controller,
        focusNode: focusNode,
        //autofocus: true,
        style: const TextStyle(
          color: BiteColors.black,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        cursorColor: BiteColors.black,
        decoration: InputDecoration(
          filled: true,
          fillColor: BiteColors.primaryColor,
          hintText: context.l10n!.searchPOI,
          prefixIcon: const BiteIcon(
            iconName: 'icon_search',
            margin: EdgeInsets.fromLTRB(16, 12, 16, 12),
            color: BiteColors.textColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: BiteColors.textColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: BiteColors.primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: BiteColors.primaryColor,
            ),
          ),
        ),
      ),

      // On Result Tap
      onSelected: (value) {
        widget.onSelected(value);
      },
      suggestionsCallback: (search) => widget.suggestionsCallback(search),

      // Progress Indicator
      loadingBuilder: (context) {
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child:
                BiteProgressIndicator(type: BiteProgressIndicatorType.circular),
          ),
        );
      },

      // Box Results Style
      decorationBuilder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: BiteColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search Result Card
              child,
              if (widget.hasNextPage) ...[
                const BiteHorizontalDivider(
                  verticalPadding: 0,
                  height: 0,
                  thickness: 1,
                ),
                // Show More
                GestureDetector(
                  onTap: () {
                    widget.onShowMoreTap();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: BiteButtonBoldText(
                        text: context.l10n!.showMoreResults,
                        textColor: BiteColors.primaryColor,
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        );
      },
      // Error Label
      errorBuilder: (context, error) {
        return Center(
          child: BiteBodyB1Text(text: context.l10n!.genericError),
        );
      },
      // Result Card
      itemBuilder: (context, suggestion) {
        return SearchResultCard(
          result: suggestion as PoiDetail,
        );
      },
      // No results
      hideOnEmpty: true,
      emptyBuilder: (context) {
        return const SizedBox.shrink();
      },
      // Divider
      itemSeparatorBuilder: (context, index) {
        return const BiteHorizontalDivider(
          verticalPadding: 0,
          height: 0,
          thickness: 1,
        );
      },
    );
  }
}
