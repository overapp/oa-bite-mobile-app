import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/navigation/navigation_bar/navigation_destination.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class BiteNavigationBar extends StatelessWidget {
  final Function onDestinationSelected;
  final int currentPageIndex;
  final List<BiteNavigationDestination> destinations;
  final Color indicatorColor;
  final Color navigationBarBackgroundColor;

  const BiteNavigationBar({
    super.key,
    required this.onDestinationSelected,
    required this.currentPageIndex,
    required this.destinations,
    this.indicatorColor = Colors.transparent,
    this.navigationBarBackgroundColor = Colors.transparent,
  });

  List<NavigationDestination> _getDestinations() {
    return destinations
        .map((e) => NavigationDestination(
              icon: e.showBadge
                  ? Badge(
                      backgroundColor: BiteColors.errorColor,
                      alignment: Alignment.topRight,
                      child: BiteIcon(
                        iconName: e.iconName,
                        color: e.iconColor,
                      ))
                  : BiteIcon(
                      iconName: e.iconName,
                      color: e.iconColor,
                    ),
              selectedIcon: BiteIcon(
                iconName: e.selectedIconName,
                color: e.selectedIconColor,
              ),
              label: e.label,
              tooltip: e.tooltip,
              enabled: e.isEnabled,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: navigationBarBackgroundColor,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: NavigationBar(
          selectedIndex: currentPageIndex,
          destinations: _getDestinations(),
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          indicatorColor: indicatorColor,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onDestinationSelected: (int index) {
            onDestinationSelected(index);
          },
        ),
      ),
    );
  }
}
