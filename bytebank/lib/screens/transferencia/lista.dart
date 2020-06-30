import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';

const _appBarTitulo = 'Transferencias';

class ListaTranferencia extends StatefulWidget {
  final List<Tranferencia> _tranferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTranferenciaState();
  }
}

class ListaTranferenciaState extends State<ListaTranferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitulo),
      ),
      body: ListView.builder(
        itemCount: widget._tranferencias.length,
        itemBuilder: (context, indice) {
          return ItemTranferencia(widget._tranferencias[indice]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return TransferenciaForm();
              }
          )).then((transferenciaRecebida) => _addTranferencia(transferenciaRecebida));
        },
      ),
    );
  }

  _addTranferencia(Tranferencia transferenciaRecebida) {
    if(transferenciaRecebida != null) {
      setState(() {
        widget._tranferencias.add(transferenciaRecebida);
      });
    }
  }
}

class ItemTranferencia extends StatelessWidget {
  final Tranferencia _tranferencia;

  ItemTranferencia(this._tranferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text(_tranferencia.valor.toString()),
            subtitle: Text(_tranferencia.numero.toString())
        )
    );
  }
}