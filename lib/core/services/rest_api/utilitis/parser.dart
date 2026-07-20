import 'dart:developer';

abstract class Parser {
  static Object? parsingData<T>(
    // ignore: strict_top_level_inference
    var data,
    T Function(Map<String, dynamic> json) fromJson,
  ) {
    if (data is List) {
      List<T> parsed = [];
      try {
        for (var json in data) {
          parsed.add(fromJson(json));
        }
        log(parsed.runtimeType.toString());
        return parsed;
      } catch (e) {
        return null;
      }
    } else if (data is Map<String, dynamic>) {
      try {
        return fromJson(data);
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }
}