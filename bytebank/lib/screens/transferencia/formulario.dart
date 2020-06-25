import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _appBarTitulo = 'Transferencia Cadastro';

const _rotuloNumeroConta = 'Numero da conta';
const _rotuloValor = 'Valor';

const _dicaNumeroConta = 'Numero da conta';
const _dicaValor = 'Valor';

const _buttonText = 'Confirmar';

class TransferenciaForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TransferenciaFormState();
}

class TransferenciaFormState extends State<TransferenciaForm> {
  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_appBarTitulo)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: _rotuloNumeroConta,
              dica: _dicaNumeroConta,
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloValor,
              dica: _dicaValor,
              icone: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text(_buttonText),
              onPressed: () => _criarTranferencia(context),
            )
          ],
        ),
      ),
    );
  }

  _criarTranferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);

    if (numeroConta != null && valor != null)
      Navigator.pop(context, Tranferencia(valor, numeroConta));
  }
}