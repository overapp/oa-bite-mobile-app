import 'package:bite/ui/scene/bluetooth_permission/bluetooth_permission_screen.dart';
import 'package:bite/ui/scene/camera/camera_screen.dart';
import 'package:bite/ui/scene/poi_detail/poi_detail_screen.dart';
import 'package:bite/ui/scene/report_screen/report_screen.dart';
import 'package:bite/ui/scene/route_detail/route_detail_screen.dart';
import 'package:bite/ui/scene/search/search_screen.dart';
import 'package:bite/ui/scene/splash/splash_screen.dart';
import 'package:bite/ui/scene/tabs/home/home_screen.dart';
import 'package:bite/ui/scene/tabs/credits/credits_screen.dart';
import 'package:bite/ui/scene/tabs/routes/routes_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final class Routes {
// Splash Screen
  static const String splash = '/splashScreen';

// Bluetooth Permission
  static const String bluetoothPermission = '/bluetoothPermission';

// Home Tab
  static const String home = '/home';

// Search Screen
  static const String searchScreen = '/searchScreen';

// POI Detail
  static const String poiDetailScreen = '/poiDetailScreen';

// Report Screen
  static const String reportScreen = '/reportScreen';

// Camera Screen
  static const String cameraScreen = '/cameraScreen';

// Routes Tab
  static const String routes = '/routes';

// Route Detail
  static const String routeDetailScreen = '/routeDetailScreen';

// Credits Screen
  static const String creditsScreen = '/creditsScreen';
}

// Utility functions for building and managing GoRouter routes with customizable page transitions.
// Creates a GoRoute for the given route and widget page.
GoRoute _buildGoRoute(String route, Widget page) {
  return GoRoute(
    path: route,
    name: route,
    pageBuilder: (context, state) {
      return _getPage(state, route, page);
    },
  );
}

// Determines whether a specific route should have a custom transition effect.
// Pages listed in noTransitionPages will not include transitions.
bool _hasTransition(String route) {
  const noTransitionPages = [Routes.home, Routes.routes];
  return !noTransitionPages.contains(route);
}

// Generates a page for the given route and widget.
Page<dynamic> _getPage(GoRouterState state, String route, Widget page) {
  if (_hasTransition(route)) {
    return MaterialPage<void>(
        name: route,
        key: state.pageKey,
        restorationId: state.pageKey.value,
        child: page);
  } else {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: page,
      name: route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}

// Defines the application's GoRouter instance, managing navigation and route definitions.
// The router is configured with an initial location, a root navigator key, and debug logging for diagnostics.
// Routes are defined using the _buildGoRoute utility function to ensure consistency and manage transitions.
final router = GoRouter(
  initialLocation: Routes.splash,
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // Splash Screen
    _buildGoRoute(Routes.splash, const SplashScreen()),
    // Bluetooth Permission Screen
    _buildGoRoute(
        Routes.bluetoothPermission, const BluetoothPermissionScreen()),
    // Home Screen
    _buildGoRoute(Routes.home, const HomeScreen()),
    // Search Screen
    _buildGoRoute(Routes.searchScreen, const SearchScreen()),
    // Routes Screen
    _buildGoRoute(Routes.routes, const RoutesScreen()),
    // POI Detail
    _buildGoRoute(Routes.poiDetailScreen, const PoiDetailScreen()),
    // Report Screen
    _buildGoRoute(Routes.reportScreen, const ReportScreen()),
    // Camera Screen
    _buildGoRoute(Routes.cameraScreen, const CameraScreen()),
    // Route Detail Screen
    _buildGoRoute(Routes.routeDetailScreen, const RouteDetailScreen()),
    // Informations Screen
    _buildGoRoute(Routes.creditsScreen, const CreditsScreen())
  ],
);
