import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/navigation/routes.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/navigation/navigation_bar/navigation_bar.dart';
import 'package:bite/ui/components/navigation/navigation_bar/navigation_destination.dart';
import 'package:bite/ui/themes/bite_colors.dart';
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
  }

  int _getIndexFromRoute(String location) {
    switch (location) {
      case Routes.home:
        return 0;
      case Routes.routes:
        return 1;
      default:
        return 0;
    }
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
          selectedIconName: 'icon_pin_location_selected',
          label: context.l10n!.homeTabLabel,
        ),
        BiteNavigationDestination(
          iconName: 'icon_routes_black',
          selectedIconName: 'icon_selected_routes',
          label: context.l10n!.routesTabLabel,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body of the screen is defined in the subclass
      body: buildBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
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
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: BiteColors.bgDisabledColor,
                blurRadius: 7,
                spreadRadius: 0,
                offset: Offset(0, 3),
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
      bottomNavigationBar: BiteNavigationBar(
        onDestinationSelected: (index) {
          onTabSelected(context, index);
        },
        currentPageIndex: _currentIndex,
        destinations: destinations,
      ),
    );
  }
}
