import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/interceptor_contract.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    debugPrint('REQUEST...');
    debugPrint('url: ${data.url}');
    debugPrint('headers: ${data.headers}');
    debugPrint('method: ${data.method}');
    debugPrint('body ${data.body}');

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    debugPrint('RESPONSE...');
    debugPrint('headers: ${data.headers}');
    debugPrint('status code: ${data.statusCode}');
    debugPrint('body: ${data.body}');

    return data;
  }
}