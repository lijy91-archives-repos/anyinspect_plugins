import 'dart:io';

class RequestInfo {
  String requestId;
  int timeStamp;
  Map<String, dynamic> headers;
  String method;
  String uri;
  dynamic body;

  RequestInfo({
    required this.requestId,
    required this.timeStamp,
    required this.headers,
    required this.method,
    required this.uri,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'timeStamp': timeStamp,
      'headers': headers,
      'method': method,
      'uri': uri,
      'body': body,
    }..removeWhere((key, value) => value == null);
  }
}

class ResponseInfo {
  String requestId;
  int timeStamp;
  int statusCode;

  Map<String, dynamic> headers;
  dynamic body;

  ResponseInfo({
    required this.requestId,
    required this.timeStamp,
    required this.statusCode,
    required this.headers,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'timeStamp': timeStamp,
      'statusCode': statusCode,
      'headers': headers,
      'body': body,
    }..removeWhere((key, value) => value == null);
  }
}

class AnyInspectHttpInterceptor {
  bool Function(HttpClientRequest request)? filter;
  void Function(RequestInfo request) onRequest;
  void Function(ResponseInfo response) onResponse;

  AnyInspectHttpInterceptor({
    this.filter,
    required this.onRequest,
    required this.onResponse,
  });
}
