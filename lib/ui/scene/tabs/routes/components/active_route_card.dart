import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/ui/components/text/text_body_b1.dart';
import 'package:bite/ui/components/text/text_button_regular.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class ActiveRouteCard extends StatelessWidget {
  final Function onCardTapped;
  final String routeName;
  final int visitedPois;

  const ActiveRouteCard(
      {super.key,
      required this.onCardTapped,
      required this.routeName,
      required this.visitedPois});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCardTapped();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: BiteColors.primaryColor.withValues(alpha: 0.75)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BiteBodyB1Text(text: routeName),
                BiteButtonRegularText(text: context.l10n?.visitedLabel(visitedPois) ?? ''),
              ],
            ),
            const Icon(
              Icons.chevron_right,
              color: BiteColors.textColor,
            )
          ],
        ),
      ),
    );
  }
}
