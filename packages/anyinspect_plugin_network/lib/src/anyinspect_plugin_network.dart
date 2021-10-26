import 'dart:io';

import 'package:anyinspect_client/anyinspect_client.dart';

import 'anyinspect_http_interceptor.dart';
import 'anyinspect_http_overrides.dart';

class AnyInspectPluginNetwork extends AnyInspectPlugin {
  @override
  String get id => 'network';

  AnyInspectPluginNetwork() {
    AnyInspectHttpInterceptor interceptor = AnyInspectHttpInterceptor(
      onRequest: (RequestInfo requestInfo) {
        try {
          send('request', requestInfo.toJson());
        } catch (error) {}
      },
      onResponse: (ResponseInfo responseInfo) {
        try {
          send('response', responseInfo.toJson());
        } catch (error) {}
      },
    );
    HttpOverrides.global = AnyInspectHttpOverrides(interceptor);
  }
}
