import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

class TransactionWebClient {
  final Uri baseUri = Uri.http('192.168.0.234:8080', 'transactions');
  final Client client = HttpClientWithInterceptor.build(interceptors: []);

  Future<List<Transaction>> findAll() async {
    final Response response =
    await client.get(baseUri).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> saveTransaction(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(baseUri,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJson);

    return Transaction.fromJson(jsonDecode(response.body));
  }

}
