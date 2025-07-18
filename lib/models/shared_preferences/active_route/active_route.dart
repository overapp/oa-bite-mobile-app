class ActiveRoute {
  final String routeId;
  final List<PoiShortInfo> pois;
  String routeName;

  ActiveRoute({
    required this.routeId,
    required this.pois,
    required this.routeName,
  });

  factory ActiveRoute.fromJson(Map<String, dynamic> json) {
    return ActiveRoute(
      routeId: json['routeId'],
      pois: (json['pois'] as List<dynamic>)
          .map((poi) => PoiShortInfo.fromJson(poi))
          .toList(),
      routeName: json['route_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'routeId': routeId,
        'pois': pois.map((e) => e.toJson()).toList(),
        'route_name': routeName,
      };
}

enum ActiveRoutePoiStatus {
  toVisit,
  visited,
  toAvoid,
  inVisit;
}

extension ActiveRoutePoiStatusExtension on ActiveRoutePoiStatus {
  String get name => toString().split('.').last;

  static ActiveRoutePoiStatus fromString(String status) {
    return ActiveRoutePoiStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => ActiveRoutePoiStatus.toVisit,
    );
  }
}

class PoiShortInfo {
  final String poiId;
  ActiveRoutePoiStatus status;
  String name;
  String address;
  String shortDescription;

  PoiShortInfo({
    required this.poiId,
    required this.status,
    required this.name,
    required this.address,
    required this.shortDescription,
  });

  factory PoiShortInfo.fromJson(Map<String, dynamic> json) {
    return PoiShortInfo(
      poiId: json['poiId'],
      status: ActiveRoutePoiStatusExtension.fromString(json['status']),
      name: json['name'],
      address: json['address'],
      shortDescription: json['short_description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'poiId': poiId,
        'status': status.name,
        'name': name,
        'address': address,
        'short_description': shortDescription,
      };
}
