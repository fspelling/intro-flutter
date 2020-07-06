import 'dart:convert';
import 'package:bytebankWebApi/models/transfer.dart';
import 'package:http/http.dart';
import '../web_client.dart';

class TransactionWebClient {
  Future<List<Transfer>> findAll() async {
    final Response resp = await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decoderJson = jsonDecode(resp.body);

    return decoderJson.map((json) => Transfer.fromJson(json)).toList();
  }

  Future<Transfer> save(Transfer transaction) async {
    final Map<String, dynamic> transactionJson = transaction.toJson(transaction);
    final Response response = await client.post(baseUrl, headers: {
      'Content-type' : 'application/json',
      'password' : '1000'
    }, body: transactionJson);

    return Transfer.fromJson(jsonDecode(response.body));
  }
}