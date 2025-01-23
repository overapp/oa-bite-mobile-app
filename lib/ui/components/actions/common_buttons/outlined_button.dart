import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_body_b1.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class BiteOutlinedButton extends StatelessWidget {
  // Main properties
  final void Function()? onPressed;
  final String text;
  final bool isEnabled;

  // Button UI properties
  final double? width;
  final double sideWidth;
  final double borderRadius;
  final Color sideColor;
  final Color disabledSideColor;
  final Color foregroundColor;
  final Color disabledForegroundColor;

  // Text properties
  final int textMaxLines;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final Color textColor;

  // Padding properties
  final double leftTextPadding;
  final double topTextPadding;
  final double rightTextPadding;
  final double bottomTextPadding;

  // Icons properties
  final String? prefixIconName;
  final Color? prefixIconColor;
  final String? suffixIconName;
  final Color? suffixIconColor;

  const BiteOutlinedButton({
    super.key,
    // Main properties
    required this.onPressed,
    required this.text,
    this.isEnabled = true,

    // Button UI properties
    this.width = double.infinity,
    this.sideWidth = 1,
    this.borderRadius = 16,
    this.sideColor = BiteColors.primaryColor,
    this.foregroundColor = BiteColors.bgCardsColor,
    this.disabledSideColor = Colors.grey,
    this.disabledForegroundColor = Colors.grey,

    // Text properties
    this.textMaxLines = 1,
    this.textAlign = TextAlign.center,
    this.textOverflow = TextOverflow.ellipsis,
    this.textColor = BiteColors.textColor,

    // Padding properties
    this.leftTextPadding = 20,
    this.topTextPadding = 16,
    this.rightTextPadding = 20,
    this.bottomTextPadding = 16,

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
          side: BorderSide(
            color: isEnabled ? sideColor : disabledSideColor,
            width: sideWidth,
          ),
          foregroundColor: foregroundColor,
          disabledForegroundColor: disabledForegroundColor,
        ),
        // Padding between the button border and the child
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            leftTextPadding,
            topTextPadding,
            rightTextPadding,
            bottomTextPadding,
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
                  width: 24,
                  height: 24,
                ),
                const SizedBox(
                  width: 4,
                ),
              ],
              // Text
              Flexible(
                child: BiteBodyB1Text(
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
