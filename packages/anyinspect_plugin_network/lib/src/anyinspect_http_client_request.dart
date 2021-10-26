import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'anyinspect_http_client_response.dart';
import 'anyinspect_http_interceptor.dart';

class AnyInspectHttpClientRequest implements HttpClientRequest {
  final AnyInspectHttpInterceptor interceptor;
  final String uniqueId;
  final HttpClientRequest request;
  StreamController<List<int>> streamController = StreamController();

  AnyInspectHttpClientRequest(
    this.interceptor,
    this.uniqueId,
    this.request,
  );

  @override
  bool get bufferOutput => request.bufferOutput;

  @override
  set bufferOutput(bool value) => request.bufferOutput = value;

  @override
  int get contentLength => request.contentLength;

  @override
  set contentLength(int value) => request.contentLength = value;

  @override
  Encoding get encoding => request.encoding;

  @override
  set encoding(Encoding value) => request.encoding = value;

  @override
  bool get followRedirects => request.followRedirects;

  @override
  set followRedirects(bool value) => request.followRedirects = value;

  @override
  int get maxRedirects => request.maxRedirects;

  @override
  set maxRedirects(int value) => request.maxRedirects = value;

  @override
  bool get persistentConnection => request.persistentConnection;

  @override
  set persistentConnection(bool value) => request.persistentConnection = value;

  @override
  void add(List<int> data) {
    request.add(data);
  }

  @override
  void addError(error, [StackTrace? stackTrace]) {
    request.addError(error, stackTrace);
  }

  @override
  Future addStream(Stream<List<int>> stream) {
    Stream<List<int>> broadcastStream = stream.asBroadcastStream();

    broadcastStream.listen(
      (List<int> event) {
        streamController.sink.add(event);
      },
    );

    return request.addStream(broadcastStream);
  }

  @override
  Future<HttpClientResponse> close() async {
    bool skipped =
        interceptor.filter != null && !(interceptor.filter!(request));

    if (!skipped) {
      await this._reportRequest(uniqueId, request);
    }
    final response = await request.close();

    return skipped ? response : await withInterceptor(response);
  }

  @override
  HttpConnectionInfo? get connectionInfo => request.connectionInfo;

  @override
  List<Cookie> get cookies => request.cookies;

  @override
  Future<HttpClientResponse> get done => request.done;

  @override
  Future flush() {
    return request.flush();
  }

  @override
  HttpHeaders get headers => request.headers;

  @override
  String get method => request.method;

  @override
  Uri get uri => request.uri;

  @override
  void write(Object? obj) {
    request.write(obj);
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    request.writeAll(objects, separator);
  }

  @override
  void writeCharCode(int charCode) {
    request.writeCharCode(charCode);
  }

  @override
  void writeln([Object? obj = ""]) {
    request.writeln(obj);
  }

  Future<AnyInspectHttpClientResponse> withInterceptor(
    HttpClientResponse response,
  ) async {
    return AnyInspectHttpClientResponse(
      interceptor,
      uniqueId,
      response,
    );
  }

  Future<bool> _reportRequest(
    String uniqueId,
    HttpClientRequest request,
  ) async {
    Map<String, dynamic> headers = new Map();
    request.headers.forEach((String name, List<String> values) {
      if (values != null && values.length > 0) {
        headers.putIfAbsent(
            name, () => values.length == 1 ? values[0] : values);
      }
    });

    var body;

    try {
      if (!streamController.isClosed) streamController.close();
      body = await const Utf8Decoder(allowMalformed: false)
          .bind(streamController.stream)
          .join();
    } catch (e) {
      print(e);
    }

    RequestInfo requestInfo = RequestInfo(
      requestId: uniqueId,
      timeStamp: DateTime.now().millisecondsSinceEpoch,
      uri: '${request.uri}',
      headers: headers,
      method: request.method,
      body: body,
    );

    interceptor.onRequest(requestInfo);
    return true;
  }

  @override
  void abort([Object? exception, StackTrace? stackTrace]) {
    request.abort([exception, stackTrace]);
  }
}
