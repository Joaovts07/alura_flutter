import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseUri);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> saveTransaction(
      Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());
    await Future.delayed(Duration(seconds: 2 ));
    final Response response = await client.post(baseUri,
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transactionJson);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }
    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int  statusCode) {
    if(_statusCodeResponse.containsKey(statusCode)){
      return _statusCodeResponse[statusCode];
    }
    return 'Unknow Error';
  }

  static final Map<int, String> _statusCodeResponse = {
    400: 'there was error in submitting transaction',
    401: 'authentication failed',
    409: 'authentication always exists'
  };

}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
}
