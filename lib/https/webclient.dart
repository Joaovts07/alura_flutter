import 'package:bytebank/https/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()]);