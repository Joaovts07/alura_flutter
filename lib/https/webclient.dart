import 'package:bytebank/https/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

final Client client =
    HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

final Uri baseUri = Uri.http('192.168.0.234:8080', 'transactions');
