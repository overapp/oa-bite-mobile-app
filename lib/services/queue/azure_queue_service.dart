// https://learn.microsoft.com/en-us/azure/azure-functions/functions-integrate-storage-queue-output-binding?tabs=csharp

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bite/utils/logger.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;

/// Azure Storage Exception
class AzureStorageException implements Exception {
  final String message;
  final int statusCode;
  final Map<String, String> headers;
  AzureStorageException(this.message, this.statusCode, this.headers);

  @override
  String toString() {
    return 'AzureStorageException: statusCode: $statusCode, message:$message';
  }
}

/// Azure Storage Client
class AzureStorage {
  late Map<String, String> config;
  Uint8List? accountKey;

  static const String defaultEndpointsProtocol = 'DefaultEndpointsProtocol';
  static const String endpointSuffix = 'EndpointSuffix';
  static const String accountName = 'AccountName';
  static const String accountMainKey = 'AccountKey';
  static const String sharedAccessSignature = 'SharedAccessSignature';

  /// Initialize with connection string obtain information such as account name, account key, SAS if available
  AzureStorage.parse(String connectionString) {
    try {
      Map<String, String> m = {};
      var items = connectionString.split(';');
      for (var item in items) {
        var i = item.indexOf('=');
        var key = item.substring(0, i);
        var val = item.substring(i + 1);
        m[key] = val;
      }
      config = m;

      if (config.containsKey(accountMainKey)) {
        // Decode account key from base64 for signing methods
        accountKey = base64Decode(config[accountMainKey]!);
      }
    } catch (e) {
      BiteLogger().error('Parse error: $e');
    }
  }

  @override
  String toString() {
    return config.toString();
  }

  // Format Headers starting with x-ms
  String _canonicalHeaders(Map<String, String> headers) {
    var keys = headers.keys
        .where((i) => i.startsWith('x-ms-'))
        .map((i) => '$i:${headers[i]}\n')
        .toList();
    keys.sort();
    return keys.join();
  }

  String _canonicalResources(Map<String, String> items) {
    if (items.isEmpty) {
      return '';
    }
    var keys = items.keys.toList();
    keys.sort();
    BiteLogger().info(keys.map((i) => '\n$i:${items[i]}').join());
    return keys.map((i) => '\n$i:${items[i]}').join();
  }

  // Create Authorization Header using Shared Key (storage account key)
  // https://learn.microsoft.com/en-us/rest/api/storageservices/versioning-for-the-azure-storage-services
  void _sign(http.Request request) {
    request.headers['x-ms-date'] = HttpDate.format(DateTime.now());

    request.headers['x-ms-version'] = '2025-01-05';

    if (accountKey == null) {
      return;
    }

    var ce = request.headers['Content-Encoding'] ?? '';
    var cl = request.headers['Content-Language'] ?? '';
    var cz = request.contentLength == 0 ? '' : '${request.contentLength}';
    var cm = request.headers['Content-MD5'] ?? '';
    var ct = request.headers['Content-Type'] ?? '';
    var dt = request.headers['Date'] ?? '';
    var ims = request.headers['If-Modified-Since'] ?? '';
    var imt = request.headers['If-Match'] ?? '';
    var inm = request.headers['If-None-Match'] ?? '';
    var ius = request.headers['If-Unmodified-Since'] ?? '';
    var ran = request.headers['Range'] ?? '';
    var chs = _canonicalHeaders(request.headers);
    var crs = _canonicalResources(request.url.queryParameters);
    var name = config[accountName];
    var path = request.url.path;

    // Created using Azure Storage guidelines
    var sig =
        '${request.method}\n$ce\n$cl\n$cz\n$cm\n$ct\n$dt\n$ims\n$imt\n$inm\n$ius\n$ran\n$chs/$name$path$crs';

    var mac = crypto.Hmac(crypto.sha256, accountKey!);
    var digest = base64Encode(mac.convert(utf8.encode(sig)).bytes);
    var auth = 'SharedKey $name:$digest';
    request.headers['Authorization'] = auth;
  }

  /// Create a new queue
  ///
  /// 'queueName' is  mandatory.
  Future<void> createQueue(String queueName) async {
    String path =
        'https://${config[accountName]}.queue.core.windows.net/$queueName';
    var request = http.Request('PUT', Uri.parse(path));
    _sign(request);
    var res = await request.send();
    // print('${await res.stream.bytesToString()}');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return;
    }
    var message = await res.stream.bytesToString();
    throw AzureStorageException(message, res.statusCode, res.headers);
  }

  /// Put queue message
  ///
  /// 'queueName': Name of the queue is  mandatory.
  ///
  /// 'message': The message data is required
  ///
  /// 'createIfNotFound': If the queue does not exist, create it
  Future<void> putMessage({
    required String queueName,
    required String message,
    bool createIfNotFound = false,
  }) async {
    String path =
        'https://${config[accountName]}.queue.core.windows.net/$queueName/messages';
    var request = http.Request('POST', Uri.parse(path));
    request.body = '''<QueueMessage>  
    <MessageText>$message</MessageText>  
  </QueueMessage> ''';
    _sign(request);
    BiteLogger().warning('Request: path $path, headers: ${request.headers}');
    var res = await request.send();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      BiteLogger().warning('SUCCESS');
      return;
    } else if (res.statusCode == 404 && createIfNotFound) {
      await createQueue(queueName);
      await putMessage(
        queueName: queueName,
        message: message,
        createIfNotFound: false,
      );

      var rMessage = await res.stream.bytesToString();

      BiteLogger().error('ERROR: $rMessage, ${res.statusCode}, ${res.headers}');
    }

    //DEBUG
    var rMessage = await res.stream.bytesToString();

    BiteLogger().error('$rMessage, ${res.statusCode}, ${res.headers}');
  }
}
