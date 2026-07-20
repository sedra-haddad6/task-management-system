
import 'package:dio/dio.dart';

enum RequestMethod {
  get,
  post,
  put,
  patch,
  delete;

  String get value => name.toUpperCase();
}

class Request<T> {
  /// Type of request [RequestMethod]
  RequestMethod method;

  /// Api end point
  String endPoint;

  /// Is the end point already a full url or not
  bool isFullURL;

  /// Used to cancel the request
  late CancelToken cancelToken;

  /// Custom header (overrides the default headers completely)
  Map<String, dynamic>? header;

  /// Header keys/values merged on top of the default headers
  Map<String, dynamic>? copyHeader;

  /// Query params
  Map<String, dynamic>? params;

  /// Body of the request
  // ignore: strict_top_level_inference
  var body;

  Function(int count, int total)? onReceiveProgress;
  Function(int count, int total)? onSendProgress;

  /// Optional model mapping
  T Function(Map<String, dynamic> json)? fromJson;

  Request({
    required this.endPoint,
    this.isFullURL = false,
    this.method = RequestMethod.get,
    this.header,
    this.copyHeader,
    this.params,
    this.body,
    CancelToken? cancelToken,
    this.fromJson,
    this.onReceiveProgress,
    this.onSendProgress,
  }) {
    if (header != null && copyHeader != null) {
      throw Exception(
        "Can't pass both header and copyHeader when creating Request instance",
      );
    }
    if (method == RequestMethod.get &&
        (body != null || onSendProgress != null)) {
      throw Exception(
        "Get request must not have body or onSendProgress parameters",
      );
    }
    this.cancelToken = cancelToken ?? CancelToken();
  }

  void stop() {
    cancelToken.cancel();
  }
}