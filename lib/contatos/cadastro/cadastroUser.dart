/*import 'dart:io';

import 'package:Agenda_de_Lembretes/contatos/lista/listContato.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cadastroUserLayout.dart';

class CadastroContato extends StatefulWidget {
  @override
  _CadastroContatoState createState() => _CadastroContatoState();
}

class _CadastroContatoState extends State<CadastroContato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        leading: Builder(
          builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ListaDeContatos();
                  }),
                );
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: BodyLayout(),
    );
  }
}
*/
