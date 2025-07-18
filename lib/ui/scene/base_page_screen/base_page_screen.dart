import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/models/shared_preferences/active_route/active_route.dart';
import 'package:bite/navigation/routes.dart';
import 'package:bite/ui/components/communications/progress_indicator.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/navigation/bottom_app_bar/bottom_app_bar.dart';
import 'package:bite/ui/components/navigation/navigation_bar/navigation_bar.dart';
import 'package:bite/ui/components/navigation/navigation_bar/navigation_destination.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:bite/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Abstract base class for screens with navigation bar.
abstract class BasePageScreen extends StatefulWidget {
  const BasePageScreen({super.key});
}

abstract class BasePageScreenState<T extends BasePageScreen> extends State<T> {
  /// Abstract method for building the body of the screen. Must be implemented by subclasses.
  Widget buildBody(BuildContext context);

  /// Represents the currently selected tab
  int _currentIndex = 0;

  bool _showRoutesBadge = false;
  bool _badgeLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetching the route to the top of the stack
    final location =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    setState(() {
      // Update selected Tab
      _currentIndex = _getIndexFromRoute(location);
    });

    _loadBadgePreference();
  }

  Future<void> _loadBadgePreference() async {
    StorageUtils storageUtils = await StorageUtils.getInstance();

    final ActiveRoute? activeRoute = await storageUtils.getActiveRoute(
      StorageUtils.activeRoute,
    );

    final shouldShow = activeRoute != null ? true : false;
    if (mounted) {
      setState(() {
        _showRoutesBadge = shouldShow;
        _badgeLoaded = true;
      });
    }
  }

  int _getIndexFromRoute(String location) {
    if (location.startsWith(Routes.home)) {
      return 0;
    } else if (location.startsWith(Routes.routes)) {
      return 1;
    }
    return _currentIndex;
  }

  /// Function to manage tab selection
  void onTabSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(Routes.home);
        break;
      case 1:
        context.go(Routes.routes);
        break;
    }
  }

  // Available Tabs
  List<BiteNavigationDestination> get destinations => [
        BiteNavigationDestination(
          iconName: 'icon_pin_location',
          selectedIconName: 'icon_pin_location',
          selectedIconColor: BiteColors.primaryColor,
          label: context.l10n!.homeTabLabel,
        ),
        BiteNavigationDestination(
          iconName: 'icon_routes_black',
          selectedIconName: 'icon_routes_black',
          selectedIconColor: BiteColors.primaryColor,
          label: context.l10n!.routesTabLabel,
          showBadge: _showRoutesBadge,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    // Property to check if the keyboard is open
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    if (!_badgeLoaded) {
      return const BiteProgressIndicator(
          type: BiteProgressIndicatorType.circular);
    }

    return Scaffold(
      extendBody: true,
      // The body of the screen is defined in the subclass
      body: buildBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: isKeyboardOpen
          ? null
          : GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                context.push(Routes.creditsScreen, extra: {
                  'calledFrom': GoRouter.of(context)
                      .routeInformationProvider
                      .value
                      .uri
                      .toString()
                });
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: BiteColors.textColor.withAlpha(20),
                      blurRadius: 16,
                      spreadRadius: 0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: BiteIcon(
                      iconName: 'icon_green',
                    ),
                  ),
                ),
              ),
            ),
      bottomNavigationBar: BiteBottomAppBar(
        padding: EdgeInsets.zero,
        notchMargin: 1,
        child: BiteNavigationBar(
          onDestinationSelected: (index) {
            onTabSelected(context, index);
          },
          currentPageIndex: _currentIndex,
          destinations: destinations,
        ),
      ),
    );
  }
}
