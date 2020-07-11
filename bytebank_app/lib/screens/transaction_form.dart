import 'package:bytebank_app/components/progress.dart';
import 'package:bytebank_app/components/response_dialog.dart';
import 'package:bytebank_app/components/transaction_auth_dialog.dart';
import 'package:bytebank_app/http/webclients/transaction_webclient.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/models/transfer.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;
  final TransactionWebClient webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();

  TransactionForm(this.contact);

  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Progress(message: 'sending...'),
                ),
                visible: _loading,
              ),
              Text(
                widget.contact.fullName,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.account.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () =>
                        showDialog(
                            context: context,
                            builder: (contextDialog) {
                              return TransactionAuthDialog(
                                onConfirm: (String password) => _saveTransaction(password, context),
                              );
                            }
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveTransaction(String password, BuildContext context) async {
    final double value = double.tryParse(_valueController.text);
    final transactionCreated = Transfer(widget.transactionId, widget.contact, value);
    final Transfer transaction = await _save(transactionCreated, password);

    _showSuccessDialog(transaction);
  }

  Future<Transfer> _save(Transfer transactionCreated, String password) async {
    final Transfer transaction = await _send(transactionCreated, password);
    _showSuccessDialog(transaction);
  }

  Future<Transfer> _send(Transfer transactionCreated, String password) async {
    setState(() => _loading = true);

    return await widget.webClient.save(transactionCreated, password)
        .catchError(
            (e) => _showFailureDialog(message: e.message),
            test: (e) => e is HttpResponseException)
        .catchError(
            (e) => _showFailureDialog(message: 'timeout submitting the transaction'),
            test: (e) => e is HttpInterceptorException)
        .catchError(
            (e) => _showFailureDialog(),
            test: (e) => e is Exception)
        .whenComplete(() => setState(() => _loading = false));
  }

  Future _showFailureDialog({ String message = 'Unkown error' }) {
    return showDialog(context: context, builder: (contextDialog) {
      return FailureDialog(message: message,);
    });
  }

  void _showSuccessDialog(Transfer transaction) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) => SuccessDialog(message: 'successful transaction')
      );
      Navigator.of(context).pop();
    }
  }
}
