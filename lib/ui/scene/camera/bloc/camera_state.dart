import 'dart:io';

abstract class CameraState {}

class CameraInitial extends CameraState {}

class CameraLoading extends CameraState {}

class CameraSuccess extends CameraState {}

class CameraImagePreview extends CameraState {
  File image;

  CameraImagePreview({
    required this.image,
  });
}

class CameraError extends CameraState {}



