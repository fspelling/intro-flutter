import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatelessWidget{
  final TextEditingController _controller = TextEditingController();
  final Function(String password) onConfirm;

  TransactionAuthDialog({ @required this.onConfirm });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
        style: TextStyle(fontSize: 64, letterSpacing: 24),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text('confirm'),
          onPressed: () {
            onConfirm(_controller.text);
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}