import 'package:bite/ui/components/text/text.dart';
import 'package:bite/ui/themes/bite_text.dart';
import 'package:flutter/material.dart';

class BiteTitleH2Text extends BiteText {
  const BiteTitleH2Text({
    super.key,
    required super.text,
    super.textAlign,
    super.textColor,
    super.underlined,
    super.overflow,
    super.maxLines,
  });

  @override
  TextStyle getTextStyle(BuildContext context) {
    return biteTextTheme.titleMedium!;
  }
}
