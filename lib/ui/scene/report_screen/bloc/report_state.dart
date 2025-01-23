// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

abstract class ReportState {
  String poiId;

  ReportState({
    required this.poiId,
  });
}

class ReportInitial extends ReportState {
  ReportInitial({required super.poiId});
}

class ReportLoading extends ReportState {
  ReportLoading({required super.poiId});
}

class ReportImageSelected extends ReportState {
  ReportImageSelected({required super.poiId});
}

class ReportUploadLoading extends ReportState {
  ReportUploadLoading({required super.poiId});
}

class ReportSuccess extends ReportState {
  File image;

  ReportSuccess({
    required this.image,
    required super.poiId,
  });
}

class ReportUploadComplete extends ReportState {
  ReportUploadComplete({required super.poiId});
}

class ReportError extends ReportState {
  String message;

  ReportError({
    required this.message,
    required super.poiId,
  });
}

class ReportPermissionNotGranted extends ReportState {
  String errorMessage;

  ReportPermissionNotGranted({
    required this.errorMessage,
    required super.poiId,
  });
}

class ReportImageError extends ReportState {
  ReportImageError({
    required super.poiId,
  });
}
