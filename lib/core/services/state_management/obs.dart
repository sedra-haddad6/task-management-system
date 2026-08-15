import 'package:get/get.dart';

import 'variable_status.dart';

class Obs<T> {
  late Rx<VariableStatus> _status;
  VariableStatus get status => _status.value;
  set status(VariableStatus value) => _status.value = value;

  String? _error;
  String? get error => _error;
  set error(String? value) {
    _error = value;
    if (value != null) {
      status = VariableStatus.hasError;
    }
  }

  T? _data;
  T? get data => _data;
  set data(T? value) {
    _data = value;
    if (value == null || (value is List && value.isEmpty)) {
      status = VariableStatus.loading;
    } else {
      status = VariableStatus.hasData;
      _status.refresh();
    }
  }

  Obs(T? data) {
    _data = data;
    if (data == null || (data is List && data.isEmpty)) {
      _status = VariableStatus.loading.obs;
    } else {
      _status = VariableStatus.hasData.obs;
    }
  }

  void reset() {
    data = null;
    status = VariableStatus.loading;
  }
}