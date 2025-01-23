abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoaded extends SplashState {
  final String? welcomeMessage;

  SplashLoaded({
    required this.welcomeMessage,
  });
}

class SplashPermissionChechLoaded extends SplashState {
  final bool? shouldAskBluetoothPermission;

  SplashPermissionChechLoaded({
    required this.shouldAskBluetoothPermission,
  });
}

class SplashError extends SplashState {}

class Registered extends SplashState {}
