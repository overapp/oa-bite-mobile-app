import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class BiteTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color bgColor;
  final Color hintTextColor;

  const BiteTextArea({
    super.key,
    required this.controller,
    required this.hintText,
    this.bgColor = Colors.transparent,
    this.hintTextColor = BiteColors.neutral1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        maxLength: 150,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintTextColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: BiteColors.textColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: BiteColors.primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: BiteColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
