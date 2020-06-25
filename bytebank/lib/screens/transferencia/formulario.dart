import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

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
          title: Text('Cadastro')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: 'Numero da conta',
              dica: '0000',
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: 'Valor',
              dica: '0,00',
              icone: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text('Confirmar'),
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

    if (numeroConta != null && valor != null) {
      final transferencia = Tranferencia(valor, numeroConta);
      debugPrint('criando transferencia...');
      debugPrint(transferencia.toString());
      Navigator.pop(context, transferencia);
    }
  }
}