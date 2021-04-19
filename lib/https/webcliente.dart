import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Uri baseUri = Uri.http('192.168.0.234:8080', 'transactions');
final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}

Future<List<Transaction>> findAll() async {
  final Response response =
      await client.get(baseUri).timeout(Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];

    final Transaction transaction = Transaction(
      transactionJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountName'],
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}

Future<Transaction> saveTransaction(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber
    }
  };
  final String transactionJson = jsonEncode(transactionMap);
  final Response response = await client.post(baseUri,
      headers: {'Content-type': 'application/json', 'password': '1000'},
      body: transactionJson);

  final Map<String, dynamic> returnJson = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = returnJson['contact'];
  return Transaction(
    returnJson['value'],
    Contact(0, contactJson['name'], contactJson['accountNumber'].toString()),
  );
}
