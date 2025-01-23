import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/ui/components/communications/progress_indicator.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_button_bold.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';


class BiteSearchBar<T extends Object> extends StatefulWidget {
  final String hintText;
  final String? prefixIconName;
  final double borderRadius;
  final Color borderColor;
  final InputBorder border;
  final Color fillColor;
  final Future<List<T>> Function(String query) fetchOptions;
  final Function(T) onSelected;
  final Function? onFocused;
  final bool autofocus;
  final bool showMore;
  final Function? onShowMoreTapped;
  final String Function(T) displayStringForOption;
  final Widget Function(T) resultBuilder;

  const BiteSearchBar({
    super.key,
    required this.hintText,
    required this.fetchOptions,
    required this.onSelected,
    required this.displayStringForOption,
    required this.resultBuilder,
    this.onFocused,
    this.prefixIconName = 'icon_search',
    this.borderColor = BiteColors.primaryColor,
    this.fillColor = BiteColors.primaryColor,
    this.borderRadius = 16,
    this.border = InputBorder.none,
    this.autofocus = false,
    this.showMore = false,
    this.onShowMoreTapped,
  });

  @override
  State<StatefulWidget> createState() => _BiteSearchBarState<T>();
}

class _BiteSearchBarState<T extends Object> extends State<BiteSearchBar<T>> {
  List<T> _options = [];
  bool _isLoading = false;

  void _onTextChanged(String query) async {
    if (query.isEmpty) {
      setState(() {
        _options = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    List<T> results = await widget.fetchOptions(query);

    setState(() {
      _options = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.fillColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.borderColor,
          width: 1,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Autocomplete<T>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return Iterable<T>.empty();
            }
            return _options;
          },
          displayStringForOption: widget.displayStringForOption,
          onSelected: widget.onSelected,
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              autofocus: widget.autofocus,
              onChanged: _onTextChanged,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: BiteColors.textColor,
              ),
              onTap:
                  widget.onFocused != null ? () => widget.onFocused!() : null,
              decoration: InputDecoration(
                prefixIcon: widget.prefixIconName != null
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 16, 15),
                        child: BiteIcon(
                          iconName: widget.prefixIconName!,
                          color: BiteColors.textColor,
                        ),
                      )
                    : null,
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: BiteColors.textColor,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: widget.border,
                suffixIcon: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: BiteProgressIndicator(
                          type: BiteProgressIndicatorType.circular,
                        ),
                      )
                    : null,
              ),
              cursorColor: BiteColors.textColor,
            );
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<T> onSelected, Iterable<T> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                width: constraints.biggest.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: widget.borderColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 8),
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final T option = options.elementAt(index);
                        return GestureDetector(
                          onTap: () => onSelected(option),
                          child: widget.resultBuilder(option),
                        );
                      },
                    ),
                    if (widget.showMore)
                      GestureDetector(
                        onTap: widget.onShowMoreTapped != null
                            ? () => widget.onShowMoreTapped!()
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: BiteButtonBoldText(
                            text: context.l10n!.showMoreResults,
                            textColor: BiteColors.primaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
