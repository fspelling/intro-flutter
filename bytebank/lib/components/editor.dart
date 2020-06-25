import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({ this.controlador, this.dica, this.rotulo, this.icone });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
            controller: controlador,
            style: TextStyle(
                fontSize: 24.0
            ),
            decoration: InputDecoration(
                labelText: this.rotulo,
                hintText: this.dica,
                icon: this.icone != null ? Icon(this.icone) : null
            ),
            keyboardType: TextInputType.number
        )
    );
  }
}
