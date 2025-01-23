import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class BiteOutlinedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool obscureText;
  final TextInputType keyboardType;
  final void Function(String) onChange;
  final void Function(String) onFieldSubmitted;
  final int? maxLength;
  final bool readOnly;
  final Color focusColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Color disabledBorderColor;
  final double borderRadius;
  final FontWeight titleFontWeight;
  final double titleFontSize;
  final int? minLines;
  final int? maxLines;
  final Color titleTextColor;
  final bool showSuffixIcon;
  final Color suffixIconColor;
  final bool hasError;
  final String errorMessage;
  final Color hasErrorColor;
  final void Function(bool hasError)? onErrorChange;
  final String? Function(String?)? validator;

  const BiteOutlinedTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.obscureText,
    required this.keyboardType,
    required this.onChange,
    required this.onFieldSubmitted,
    this.hasError = false,
    this.maxLength,
    this.readOnly = false,
    this.focusColor = BiteColors.textColor,
    this.focusedBorderColor = BiteColors.primaryColor,
    this.enabledBorderColor = BiteColors.primaryColor,
    this.disabledBorderColor = BiteColors.textColor,
    this.borderRadius = 16,
    this.minLines = 1,
    this.maxLines = 1,
    this.titleFontWeight = FontWeight.w500,
    this.titleFontSize = 16,
    this.titleTextColor = BiteColors.primaryColor,
    this.showSuffixIcon = false,
    this.suffixIconColor = BiteColors.primaryColor,
    this.errorMessage = '',
    this.hasErrorColor = BiteColors.errorColor,
    this.onErrorChange,
    this.validator,
  });

  @override
  State<BiteOutlinedTextField> createState() => _BiteOutlinedTextFieldState();
}

class _BiteOutlinedTextFieldState extends State<BiteOutlinedTextField> {
  bool isTextObscured = false;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    isTextObscured = widget.obscureText;
    hasError = widget.hasError;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          cursorColor: hasError ? widget.hasErrorColor : widget.titleTextColor,
          style: TextStyle(
            fontWeight: widget.titleFontWeight,
            fontSize: widget.titleFontSize,
            color: hasError ? widget.hasErrorColor : widget.titleTextColor,
          ),
          decoration: InputDecoration(
              filled: true,
              fillColor: widget.readOnly
                  ? widget.disabledBorderColor
                  : Colors.transparent,
              suffixIcon: widget.showSuffixIcon
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isTextObscured = !isTextObscured;
                        });
                      },
                      child: Icon(
                        isTextObscured
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: widget.suffixIconColor,
                      ),
                    )
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              labelText: widget.title,
              labelStyle: TextStyle(
                fontWeight: widget.titleFontWeight,
                fontSize: widget.titleFontSize,
                color: widget.titleTextColor,
              ),
              focusColor: widget.focusColor,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: hasError
                        ? widget.hasErrorColor
                        : widget.focusedBorderColor),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.hasErrorColor),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: hasError
                        ? widget.hasErrorColor
                        : widget.enabledBorderColor),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.disabledBorderColor),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.hasErrorColor),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              )),
          obscureText: isTextObscured,
          validator: widget.validator,
          onChanged: (value) {
            widget.onChange(value);
          },
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly,
          onFieldSubmitted: (value) => widget.onFieldSubmitted(value),
        ),
      ],
    );
  }
}
