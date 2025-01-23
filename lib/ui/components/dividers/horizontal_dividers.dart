import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class BiteHorizontalDivider extends StatelessWidget {
  final double verticalPadding;
  final double horizontalPadding;
  final Color color;
  final double height;
  final double thickness;
  final double indent;
  final double endIndent;

  const BiteHorizontalDivider({
    super.key,
    this.verticalPadding = 16.0,
    this.horizontalPadding = 0,
    this.color = BiteColors.primaryColor,
    this.height = 50,
    this.thickness = 0,
    this.indent = 0,
    this.endIndent = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Divider(
        color: color,
        height: height,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}
