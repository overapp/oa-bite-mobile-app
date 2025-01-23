import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_body_b1.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class BiteFilledButton extends StatelessWidget {
  // Main properties
  final void Function()? onPressed;
  final String text;
  final bool isEnabled;

  // Button UI properties
  final double? width;
  final double borderRadius;
  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final Color foregroundColor;
  final Color disabledForegroundColor;

  // Text properties
  final int textMaxLines;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final Color textColor;
  final double? textFontSize;
  final FontWeight? textFontWeight;

  // Padding properties
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;

  // Icons properties
  final String? prefixIconName;
  final Color? prefixIconColor;
  final String? suffixIconName;
  final Color? suffixIconColor;

  const BiteFilledButton({
    super.key,
    // Main properties
    required this.onPressed,
    required this.text,
    this.isEnabled = true,

    // Button UI properties
    this.width = double.infinity,
    this.borderRadius = 16,
    this.backgroundColor = BiteColors.primaryColor,
    this.disabledBackgroundColor = BiteColors.bgAlertColor,
    this.foregroundColor = BiteColors.textColor,
    this.disabledForegroundColor = BiteColors.neutral1,

    // Text properties
    this.textMaxLines = 1,
    this.textAlign = TextAlign.center,
    this.textOverflow = TextOverflow.ellipsis,
    this.textColor = BiteColors.textColor,
    this.textFontWeight,
    this.textFontSize,

    // Padding properties
    this.leftPadding = 20,
    this.topPadding = 16,
    this.rightPadding = 20,
    this.bottomPadding = 16,

    // Icons properties
    this.prefixIconName,
    this.prefixIconColor,
    this.suffixIconName,
    this.suffixIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: isEnabled ? onPressed : null,
        clipBehavior: Clip.antiAlias,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: backgroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          foregroundColor: foregroundColor,
          disabledForegroundColor: disabledForegroundColor,
        ),
        // Padding between the button border and the child
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            leftPadding,
            topPadding,
            rightPadding,
            bottomPadding,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Prefix icon
              if (prefixIconName != null) ...[
                BiteIcon(
                  iconName: prefixIconName!,
                  color: prefixIconColor,
                ),
                const SizedBox(
                  width: 4,
                ),
              ],
              // Text
              Flexible(
                child: textFontSize != null && textFontWeight != null
                    ? Text(
                        text,
                        style: TextStyle(
                          fontSize: textFontSize,
                          fontWeight: textFontWeight,
                          color: textColor,
                          fontFamily: 'Urbanist',
                        ),
                      )
                    : BiteBodyB1Text(
                        text: text,
                        maxLines: textMaxLines,
                        textAlign: textAlign,
                        overflow: textOverflow,
                        textColor: textColor,
                      ),
              ),
              // Suffix icon
              if (suffixIconColor != null) ...[
                const SizedBox(
                  width: 4,
                ),
                BiteIcon(
                  iconName: suffixIconName!,
                  color: suffixIconColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
