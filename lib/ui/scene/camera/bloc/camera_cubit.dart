import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bite/ui/scene/camera/bloc/camera_state.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial()) {
    takeImage();
  }

  XFile? selectedImage;
  List<CameraDescription>? cameras;
  late CameraController cameraController;

  void takeImage() async {
    // Get availables cameras
    cameras = await availableCameras();

    await cameraPermissions();

    await initialiazeCameraController();
  }

  Future<void> cameraPermissions() async {
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
  }

  Future<void> initialiazeCameraController() async {
    try {
      if (cameras == null || cameras!.isEmpty) {
        cameras = await availableCameras();
        if (cameras!.isEmpty) {
          emit(CameraError());
          return;
        }
      }

      final CameraDescription camera = cameras!.first;

      cameraController = CameraController(
        camera,
        ResolutionPreset.high,
      );

      await cameraController.initialize();

      emit(CameraSuccess());
    } catch (e) {
      emit(CameraError());
    }
  }

  void takePicture() async {
    try {
      final XFile picture = await cameraController.takePicture();

      selectedImage = picture;
      emit(CameraImagePreview(image: File(picture.path)));
    } catch (e) {
      emit(CameraError());
    }
  }
}
