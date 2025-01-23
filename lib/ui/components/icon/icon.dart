import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Custom icon based on svg file contains inside assets/svg folder
class BiteIcon extends StatelessWidget {
  final String iconName;
  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsets? margin;
  final List<BoxShadow>? boxShadow;

  const BiteIcon({
    super.key,
    required this.iconName,
    this.width,
    this.height,
    this.color,
    this.margin,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
      ),
      child: SvgPicture.asset(
        'assets/svg/$iconName.svg',
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        width: width,
        height: height,
      ),
    );
  }
}
