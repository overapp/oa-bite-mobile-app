import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

// Types of progress indicators
enum BiteProgressIndicatorType {
  circular,
  linear,
}

// Progress indicator widget, which can be either circular or linear
class BiteProgressIndicator extends StatelessWidget {
  final BiteProgressIndicatorType type;
  final Color? color;

  /// The `strokeWidth` property is only applicable to Circular Progress Indicators.
  /// It defines the width of the circular progress indicator's line.
  final double? strokeWidth;

  const BiteProgressIndicator({
    super.key,
    required this.type,
    this.color = BiteColors.primaryColor,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case BiteProgressIndicatorType.circular:
        return CircularProgressIndicator(
          color: color,
          strokeWidth: strokeWidth ?? 4,
        );
      case BiteProgressIndicatorType.linear:
        return LinearProgressIndicator(
          color: color,
        );
    }
  }
}
