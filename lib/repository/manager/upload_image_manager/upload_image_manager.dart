import 'dart:io';

import 'package:bite/models/network_response/network_response.dart';
import 'package:bite/models/request_type/request_type.dart';
import 'package:bite/services/image_upload/upload_image_service.dart';
import 'package:bite/utils/logger.dart';

/// Manages the process of uploading images to Azure Blob Storage,

class UploadImageManager {
  Future uploadImage(
    String url,
    String mime,
    File file,
    Function success,
    Function error,
  ) async {
    final getBytes = await file.readAsBytes();

    final body = Stream.fromIterable(getBytes.map((e) => [e]));

    final headers = {
      'Content-Type': mime,
      'x-ms-blob-type': 'BlockBlob',
      'Content-Length': getBytes.length.toString(),
    };

    NetworkResponse? upload = await UploadImage().request(
      url: url,
      requestType: RequestType.PUT,
      headers: headers,
      body: body,
    );

    return upload.maybeWhen(onSuccess: (response, status, message) async {
      final headers = response.headers;
      final etag = headers?['etag']?.first.replaceAll('"', '');

      BiteLogger().info('ETag: $etag');

      if (etag != null) {
        return success(response.data, etag);
      } else {
        BiteLogger().error('ETag not avaiable');
        return success(response);
      }
    }, loading: (message) {
      return null;
    }, onError: (status, message) {
      return error(status, message);
    }, orElse: () {
      return error('unknown error', 'unknown error');
    });
  }
}
