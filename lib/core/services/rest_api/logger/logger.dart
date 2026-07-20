import 'dart:developer';

import '../models/request.dart';
import '../models/response_model.dart';

void requestingLogger(Request request) {
  log('############# API SERVICE #############', name: "API SERVICE");
  log('Requesting ${request.method.name} ${request.endPoint}', name: "API SERVICE");
  log('Params     ${request.params}', name: "API SERVICE");
  if (request.body != null) {
    log('Body       ${request.body}', name: "API SERVICE");
  }
  log('#########################################', name: "API SERVICE");
}

void resultLogger(Request request, ResponseModel response) {
  log('############# API SERVICE #############', name: "API SERVICE");
  log('Response of ${request.method.name} ${request.endPoint}', name: "API SERVICE");
  log('${response.toJson()}', name: "API SERVICE");
  log('#########################################', name: "API SERVICE");
}

void headerLogger(Map header) {
  log('############# API SERVICE #############', name: "API SERVICE");
  log('Main Header', name: "API SERVICE");
  log('$header', name: "API SERVICE");
  log('#########################################', name: "API SERVICE");
}