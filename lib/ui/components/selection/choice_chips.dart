import 'package:bite/ui/components/communications/progress_indicator.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_body_chips.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class BiteChip extends StatelessWidget {
  // Text properties
  final String? label;
  final Color textColor;

  // Icons properties
  final String? prefixIconName;
  final Color? prefixIconColor;
  final String? suffixIconName;
  final Color? suffixIconColor;

  // Chip UI properties
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;

  // State properties
  final bool isLoading;

  const BiteChip({
    super.key,
    // Text properties
    this.label,
    this.textColor = BiteColors.textColor,

    // Icons properties
    this.prefixIconName,
    this.prefixIconColor,
    this.suffixIconName,
    this.suffixIconColor,

    // Chip UI properties
    this.backgroundColor = Colors.transparent,
    this.borderColor = BiteColors.textColor,
    this.borderWidth = 0.3,

    // State properties
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Prefix icon
          if (prefixIconName != null) ...[
            BiteIcon(
              iconName: prefixIconName!,
              color: prefixIconColor,
            ),
            const SizedBox(width: 10),
          ],
          // Progress Indicator
          if (isLoading)
            const SizedBox(
              height: 16,
              width: 16,
              child: BiteProgressIndicator(
                type: BiteProgressIndicatorType.circular,
                strokeWidth: 2,
              ),
            )
          else
          // Text
            BiteBodyChipsText(
              text: label ?? '-',
            ),
          // Suffix icon
          if (suffixIconName != null) ...[
            const SizedBox(width: 10),
            BiteIcon(
              iconName: suffixIconName!,
              color: suffixIconColor,
            ),
          ],
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      backgroundColor: backgroundColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: 0,
      pressElevation: 0,
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 8,
      ),
    );
  }
}
