import 'dart:convert';
import 'package:bytebank_app/models/transfer.dart';
import 'package:http/http.dart';
import '../web_client.dart';

class TransactionWebClient {
  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction already exists'
  };

  Future<List<Transfer>> findAll() async {
    final Response resp = await client.get(baseUrl);
    final List<dynamic> decoderJson = jsonDecode(resp.body);

    return decoderJson.map((json) => Transfer.fromJson(json)).toList();
  }

  Future<Transfer> save(Transfer transaction, String password) async {
    final Map<String, dynamic> transactionJson = transaction.toJson();
    final Response response = await client.post(baseUrl, headers: {
      'Content-type' : 'application/json',
      'password' : password
    }, body: jsonEncode(transactionJson));

    if (response.statusCode == 200)
      return Transfer.fromJson(jsonDecode(response.body));

    throw HttpResponseException(_getMessageResponse(response.statusCode));
  }

  String _getMessageResponse(int statusCode) {
    final String message = _statusCodeResponses.containsKey(statusCode) ?
        _statusCodeResponses[statusCode] :
        'Unkown error';

    return message;
  }
}

class HttpResponseException implements Exception {
  final String message;

  HttpResponseException(this.message);
}