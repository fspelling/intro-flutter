import 'package:bytebank_intro/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.green[500],
            accentColor: Colors.lightBlueAccent[200],
            buttonTheme: ButtonThemeData(
                buttonColor: Colors.lightBlueAccent[200],
                textTheme: ButtonTextTheme.primary
            )
        ),
        home: ListaTranferencia()
    );
  }
}