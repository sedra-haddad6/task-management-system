import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import 'constants/api_error.dart';
import 'handlers/error_handler.dart';
import 'handlers/success_handler.dart';
import 'logger/logger.dart';
import 'models/exceptions.dart';
import 'models/request.dart';
import 'models/response_model.dart';
import 'constants/end_points.dart';

class APIService extends GetxService {
  static APIService get instance => Get.find<APIService>();

  //=========== CONFIGURATION ===========
  late bool withLog;
  late Map<String, dynamic> _headers;
  late Dio _dio;

  APIService({
    this.withLog = true,
    Map<String, dynamic>? headers,
    String? token,
    String? language,
  }) {
    _headers = headers ?? {};
    if (token != null) {
      _headers["Authorization"] = "Bearer $token";
    }
    if (language != null) {
      _headers["Accept-Language"] = language;
    }
    _dio = Dio();
    _dio.options = BaseOptions(headers: _headers, responseType: ResponseType.json);
    if (withLog) headerLogger(_headers);
  }

  void setToken(String? token) {
    if (token == null) {
      _headers.remove("Authorization");
    } else {
      _headers["Authorization"] = "Bearer $token";
    }
    _dio.options = _dio.options.copyWith(headers: _headers);
    if (withLog) headerLogger(_headers);
  }

  void setLanguage(String language) {
    _headers["Accept-Language"] = language;
    _dio.options = _dio.options.copyWith(headers: _headers);
    if (withLog) headerLogger(_headers);
  }

  String? get language => _headers["Accept-Language"];

  //============== API Request ================
  Future<ResponseModel> request<T>(Request<T> request) async {
    String fullEndPoint = request.isFullURL
        ? request.endPoint
        : EndPoints.baseUrl + request.endPoint;

    ResponseModel responseModel;

    Map<String, dynamic> requestHeader = getRequestHeader(request);

    if (withLog) requestingLogger(request);

    try {
      Response response = await _dio.request(
        fullEndPoint,
        options: Options(headers: requestHeader, method: request.method.value),
        queryParameters: request.params,
        data: request.body,
        cancelToken: request.cancelToken,
        onReceiveProgress: request.onReceiveProgress,
        onSendProgress: request.onSendProgress,
      );
      responseModel = await responseModelling<T>(response, fromJson: request.fromJson);
    } on ModellingException catch (error) {
      responseModel = ResponseModel(
        success: false,
        message: error.message,
        errorType: ModellingError(),
      );
    } on DioException catch (error) {
      responseModel = mainErrorHandler(error);
    } catch (e) {
      responseModel = ResponseModel(success: false, data: e, message: 'some error')
        ..statusCode = 0;
    }

    if (withLog) resultLogger(request, responseModel);

    return responseModel;
  }

  Map<String, dynamic> getRequestHeader(Request request) {
    Map<String, dynamic> header = Map<String, dynamic>.from(request.header ?? _headers);
    if (request.copyHeader != null) {
      for (var key in request.copyHeader!.keys) {
        header[key] = request.copyHeader![key];
      }
    }
    return header;
  }

  void stop(Request request) {
    request.cancelToken.cancel();
  }
}