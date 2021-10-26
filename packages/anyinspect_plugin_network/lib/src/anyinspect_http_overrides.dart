import 'dart:io';

import 'anyinspect_http_client.dart';
import 'anyinspect_http_interceptor.dart';

class AnyInspectHttpOverrides extends HttpOverrides {
  final AnyInspectHttpInterceptor interceptor;

  AnyInspectHttpOverrides(this.interceptor);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    return AnyInspectHttpClient(client, interceptor);
  }
}
