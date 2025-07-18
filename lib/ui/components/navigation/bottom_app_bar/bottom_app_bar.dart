import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class BiteBottomAppBar extends StatelessWidget {
  final NotchedShape notchedShape;
  final double notchMargin;
  final Color color;
  final Widget child;
  final EdgeInsets padding;

  const BiteBottomAppBar({
    super.key,
    required this.child,
    this.notchedShape = const CircularNotchedRectangle(),
    this.notchMargin = 10,
    this.color = BiteColors.bgCardsColor,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: BiteColors.textColor.withAlpha(20),
            spreadRadius: 1,
            blurRadius: 16,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomAppBar(
          elevation: 33,
          padding: EdgeInsets.zero,
          shape: notchedShape,
          notchMargin: notchMargin,
          color: color,
          child: child,
        ),
      ),
    );
  }
}
