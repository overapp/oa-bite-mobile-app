import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class BiteRoutesSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color bgColor;
  final Color hintTextColor;
  final Function onChanged;
  final Function? onFieldSubmitted;

  const BiteRoutesSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.bgColor = Colors.transparent,
    this.hintTextColor = BiteColors.neutral1,
    required this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: hintTextColor,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      cursorColor: hintTextColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: bgColor,
        hintText: hintText,
        prefixIcon: const BiteIcon(
          iconName: 'icon_search',
          margin: EdgeInsets.fromLTRB(16, 12, 16, 12),
          color: BiteColors.textColor,
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
      onChanged: (value) {
        onChanged(value);
      },
      onSubmitted: onFieldSubmitted != null ? (value) {} : null,
    );
  }
}
