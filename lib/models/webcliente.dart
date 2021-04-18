import 'package:http/http.dart';

void findAll() async {
  Uri uri = Uri.http('192.168.0.234:8080','transactions');
  final Response response =
  await get(uri);
  print("response:" + response.body);
}