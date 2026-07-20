
import '../constants/api_error.dart';

class ResponseModel {
  late bool success;
  late String message;
  int? statusCode;
  APIError? errorType;
  // ignore: strict_top_level_inference
  var data;

  ResponseModel({
    required this.success,
    this.data,
    required this.message,
    this.errorType,
    this.statusCode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['success'] = success;
    json['status_code'] = statusCode;
    json['data'] = data;
    json['message'] = message;
    json['error_type'] = errorType?.runtimeType.toString();
    return json;
  }
}