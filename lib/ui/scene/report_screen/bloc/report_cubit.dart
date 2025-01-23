import 'dart:io';

import 'package:bite/models/responses/request_upload_link/request_upload_link.dart';
import 'package:bite/repository/manager/repo_manager/repository_manager.dart';
import 'package:bite/repository/manager/upload_image_manager/upload_image_manager.dart';
import 'package:bite/ui/scene/report_screen/bloc/report_state.dart';
import 'package:bite/utils/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit(String poiId) : super(ReportInitial(poiId: poiId));

  XFile? selectedImage;

  String? uploadUrl;
  String? mimeSelectedImage;
  ImagePicker imagePicker = ImagePicker();

  // Allows you to choose a photo from the gallery
  Future pickImage(ImageSource type) async {
    try {
      final image = await imagePicker.pickImage(source: type);
      if (image == null) {
        return;
      }
      selectedImage = image;
      _getMime(image);
      emit(ReportSuccess(poiId: state.poiId, image: File(image.path)));
    } on PlatformException catch (e) {
      emit(ReportPermissionNotGranted(
          poiId: state.poiId, errorMessage: e.toString()));
    }
  }

  // Get mime of selected image
  String _getMime(XFile selectedImage) {
    final mime = lookupMimeType(selectedImage.path);
    if (mime == null || !isValidMime(mime)) {
      emit(ReportImageError(poiId: state.poiId));
    }
    return mime ?? '';
  }

  // Validate mime
  bool isValidMime(String? mime) {
    return mime == 'image/png' || mime == 'image/jpeg';
  }

  void startUploadImage(
    XFile selectedImage,
    String poiId,
    String email,
    String description,
  ) async {
    emit(ReportUploadLoading(poiId: poiId));
    await requestUploadLink(
        poiId, selectedImage, email, _getMime(selectedImage), description);
  }

// API calls

  Future<void> requestUploadLink(
    String poiId,
    XFile file,
    String email,
    String fileType,
    String description,
  ) async {
    await RepoManager().manager.requestUploadLink(
      poiId,
      file.name,
      fileType,
      (RequestUploadLink data) {
        uploadUrl = data.url;

        final alertId = data.relatedEntityId;

        imageUpload(
          data.url ?? '',
          File(selectedImage?.path ?? ''),
          selectedImage?.name ?? '',
          _getMime(selectedImage ?? XFile('')),
          email,
          description,
          alertId ?? '',
        );

        BiteLogger().info(data.url ?? '-');
      },
      (String status, String message) {
        emit(ReportError(poiId: state.poiId, message: message));
      },
    );
  }

  Future<void> imageUpload(
    String url,
    File file,
    String imageName,
    String mime,
    String email,
    String description,
    String alertId,
  ) async {
    await UploadImageManager().uploadImage(
      url,
      mime,
      file,
      (dynamic data, String etag) {
        confirmUpload(
          state.poiId,
          etag,
          imageName,
          mime,
          email,
          description,
          alertId,
        );
      },
      (String status, String message) {
        emit(ReportError(poiId: state.poiId, message: message));
      },
    );
  }

  Future<void> confirmUpload(
    String poiId,
    String ref,
    String fileName,
    String fileType,
    String email,
    String description,
    String alertId,
  ) async {
    await RepoManager().manager.confirmUpload(
      poiId,
      ref,
      fileName,
      fileType,
      email,
      description,
      alertId,
      (dynamic status) {
        BiteLogger().info('UPLOAD STATUS: $status');
        emit(ReportUploadComplete(poiId: poiId));
      },
      (String status, String message) {
        emit(ReportError(poiId: state.poiId, message: message));
      },
    );
  }
}
