import 'package:flutter/material.dart';
import 'package:bite/ui/themes/bite_colors.dart';

// Abstract widget for texts that uses the style defined in the TextTheme
abstract class BiteText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  final bool? underlined;
  final TextOverflow? overflow;
  final int? maxLines;

  const BiteText({
    super.key,
    required this.text,
    this.textAlign,
    this.textColor = BiteColors.textColor,
    this.underlined = false,
    this.overflow,
    this.maxLines,
  });

  // Method for selecting the style
  TextStyle getTextStyle(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: getTextStyle(context).copyWith(
        color: textColor,
        fontWeight: getTextStyle(context).fontWeight,
        fontSize: getTextStyle(context).fontSize,
        fontFamily: getTextStyle(context).fontFamily,
        decoration:
            underlined == true ? TextDecoration.underline : TextDecoration.none,
        decorationColor: textColor,
      ),
    );
  }
}
