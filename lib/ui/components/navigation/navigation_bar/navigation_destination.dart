import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class BiteNavigationDestination extends StatelessWidget {
  final String iconName;
  final String selectedIconName;
  final String label;
  final bool isEnabled;
  final String? tooltip;
  final Color? iconColor;
  final Color? selectedIconColor;
  final bool showBadge;

  const BiteNavigationDestination({
    super.key,
    required this.iconName,
    required this.selectedIconName,
    this.label = '',
    this.isEnabled = true,
    this.tooltip,
    this.iconColor,
    this.selectedIconColor,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: showBadge
          ? Badge(
              backgroundColor: BiteColors.errorColor,
              alignment: Alignment.topRight,
              isLabelVisible: false,
              label: const SizedBox(width: 8, height: 8),
              child: BiteIcon(
                iconName: iconName,
                color: iconColor,
              ),
            )
          : BiteIcon(
              iconName: iconName,
              color: iconColor,
            ),
      selectedIcon: BiteIcon(
        iconName: selectedIconName,
        color: selectedIconColor,
      ),
      label: label,
      enabled: isEnabled,
      tooltip: tooltip,
    );
  }
}
