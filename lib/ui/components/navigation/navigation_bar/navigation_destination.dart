import 'package:bite/ui/components/icon/icon.dart';
import 'package:flutter/material.dart';

class BiteNavigationDestination extends StatelessWidget {
  final String iconName;
  final String selectedIconName;
  final String label;
  final bool isEnabled;
  final String? tooltip;

  const BiteNavigationDestination({
    super.key,
    required this.iconName,
    required this.selectedIconName,
    this.label = '',
    this.isEnabled = true,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: BiteIcon(iconName: iconName),
      selectedIcon: BiteIcon(iconName: selectedIconName),
      label: label,
      enabled: isEnabled,
      tooltip: tooltip,
      
    );
  }
}
