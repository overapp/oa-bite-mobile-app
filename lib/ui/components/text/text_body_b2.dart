import 'package:bite/ui/components/text/text.dart';
import 'package:bite/ui/themes/bite_text.dart';
import 'package:flutter/material.dart';

class BiteBodyB2Text extends BiteText {
  const BiteBodyB2Text ({
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
    return biteTextTheme.bodySmall!;
  }
}
