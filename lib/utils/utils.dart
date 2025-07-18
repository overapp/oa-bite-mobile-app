import 'dart:io';
import 'dart:math';
import 'package:bite/models/responses/location/location.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/models/responses/route/poi_info/poi_info.dart';
import 'package:bite/models/shared_preferences/active_route/active_route.dart';
import 'package:bite/ui/scene/route_detail/components/start_route_bottom_sheet.dart';
import 'package:bite/utils/logger.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:bite/ui/components/actions/common_buttons/filled_button.dart';
import 'package:bite/ui/components/actions/common_buttons/outlined_button.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_body_b1.dart';
import 'package:bite/ui/components/text/text_title_h1.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// Calculate distance in meters from rssi value
double calculateDistance(int rssi, int rssiCalibrated, double n) {
  return pow(10, (rssiCalibrated - rssi) / (10 * n)).toDouble();
}

String getFeaaCode(DiscoveredDevice device) {
  try {
    final feaaData = device.serviceData.entries.first.value;

    if (feaaData.isNotEmpty) {
      String feaaHex =
          feaaData.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

      if (feaaHex.length > 8) {
        return feaaHex.substring(4, feaaHex.length - 4).toUpperCase();
      }
      return feaaHex.toUpperCase();
    }
  } catch (e) {
    BiteLogger().error('Failed to get FEAA data: $e');
  }

  return '';
}

// Alert dialog
void showBiteDialog(
  BuildContext context,
  String? iconName,
  String? title,
  String? body, {
  Color? iconColor,
  String? action1Message,
  Function? onAction1Tap,
  String? action2Message,
  Function? onAction2Tap,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: BiteColors.bgAlertColor,
        icon: iconName != null && iconName.isNotEmpty
            ? BiteIcon(
                iconName: iconName,
                color: iconColor,
              )
            : null,
        alignment: Alignment.center,
        title: Align(
          alignment: Alignment.center,
          child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  if (title != null && title.isNotEmpty) ...[
                    BiteTitleH1Text(
                      text: title,
                    ),
                  ],
                  if (body != null && body.isNotEmpty) ...[
                    const SizedBox(
                      height: 8,
                    ),
                    BiteBodyB1Text(text: body)
                  ]
                ],
              )),
        ),
        actions: [
          if (action1Message != null &&
              action1Message.isNotEmpty &&
              onAction1Tap != null) ...[
            BiteOutlinedButton(
              onPressed: () {
                onAction1Tap();
              },
              text: action1Message,
            ),
          ],
          const SizedBox(
            height: 8,
          ),
          if (action2Message != null &&
              action2Message.isNotEmpty &&
              onAction2Tap != null) ...[
            BiteFilledButton(
              onPressed: () {
                onAction2Tap();
              },
              text: action2Message,
            ),
          ]
        ],
      );
    },
  );
}

// Google maps polyline
List<LatLng> decodePoly(String encoded) {
  List<LatLng> points = [];
  int index = 0;
  int lat = 0, lng = 0;

  while (index < encoded.length) {
    int shift = 0, result = 0;
    int b;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1F) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1F) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lng += dlng;

    points.add(LatLng(lat / 1E5, lng / 1E5));
  }

  return points;
}

// Methods to launch map apps
void launchMap(double latitude, double longitude) async {
  try {
    if (Platform.isAndroid) {
      const String markerLabel = 'Here';
      final url = Uri.parse(
          'geo:$latitude,$longitude?q=$latitude,$longitude($markerLabel)');
      await launchUrl(url);
    } else if (Platform.isIOS) {
      final url = Uri.parse('maps:$latitude,$longitude?q=$latitude,$longitude');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  } catch (error) {
    BiteLogger().error(error.toString());
  }
}

void startRouteBottomSheet(
 { required BuildContext context,
 required void Function(String id) onCardTap,
required  List<PoiInfo> pois,
  List<PoiShortInfo>? visitedPois,
 required String suggestedPoi,}
) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: BiteColors.primaryColor.withValues(alpha: 0.7),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.4,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
            controller: scrollController,
            child: StartRouteBottomSheet(
              onCardTapped: onCardTap,
              pois: pois,
              visitedPois: visitedPois,
              suggestedPoi: suggestedPoi,
            ));
      },
    ),
  );
}

Location getTappedPoiCordinates(RouteDetail detail, String tappedPoiId) {
  int poiOrder =
      detail.stops?.where((e) => e.poiId == tappedPoiId).firstOrNull?.order ??
          0;

  Location poiLocation = Location(
    latitude: detail.path?[poiOrder].latitude ?? 90,
    longitude: detail.path?[poiOrder].latitude ?? 90,
  );
  return poiLocation;
}


