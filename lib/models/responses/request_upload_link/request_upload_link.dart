// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_upload_link.freezed.dart';
part 'request_upload_link.g.dart';

@freezed
class RequestUploadLink with _$RequestUploadLink {
  const factory RequestUploadLink({
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'relatedEntityId') String? relatedEntityId,
  }) = _RequesUploadLink;

  factory RequestUploadLink.fromJson(Map<String, dynamic> json) =>
      _$RequestUploadLinkFromJson(json);
}
