import 'dart:io';

import 'package:anyinspect_client/anyinspect_client.dart';

import 'anyinspect_http_interceptor.dart';
import 'anyinspect_http_overrides.dart';

class AnyInspectPluginNetwork extends AnyInspectPlugin {
  @override
  String get id => 'network';

  AnyInspectPluginNetwork() {
    AnyInspectHttpInterceptor interceptor = AnyInspectHttpInterceptor(
      onRequest: _onRequest,
      onResponse: _onResponse,
    );
    HttpOverrides.global = AnyInspectHttpOverrides(interceptor);
  }

  void _onRequest(RequestInfo requestInfo) {
    try {
      emitEvent('request', requestInfo.toJson());
    } catch (error) {}
  }

  void _onResponse(ResponseInfo responseInfo) {
    try {
      emitEvent('response', responseInfo.toJson());
    } catch (error) {}
  }
}
