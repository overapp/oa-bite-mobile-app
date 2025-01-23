import 'package:bite/models/responses/route/get_routes/get_routes.dart';

abstract class RoutesState {}

class RoutesInitial extends RoutesState {}

class RoutesLoading extends RoutesState {}

class RoutesSuccess extends RoutesState {
  final GetRoutes routes;

  RoutesSuccess({
    required this.routes,
  });
}

class RoutesError extends RoutesState {
  final String message;

  RoutesError({
    required this.message,
  });
}
