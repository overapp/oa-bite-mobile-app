abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomePermissionDenied extends HomeState {}

class HomeError extends HomeState {
  String message;

  HomeError({
    required this.message,
  });
}

class HomeGetPositionError extends HomeState {
  String message;

  HomeGetPositionError({
    required this.message,
  });
}
