import 'dart:convert';

import 'package:bytebank_full/models/Contact.dart';
import 'package:bytebank_full/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor extends InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print("Request");
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("Response");
    print('statusCode: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}

Future<List<Transaction>> findAll() async {
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(
    Uri.parse("http://192.168.1.5:8080/transactions"),
  );

  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transacao = Transaction(
      transactionJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(transacao);
  }
  return transactions;
}
