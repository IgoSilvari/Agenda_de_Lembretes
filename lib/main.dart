import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'contatos/editarContatos/editarItensCadastrados.dart';
import 'contatos/lista/listContato.dart';
import 'homescreen.dart';

void main() => runApp(Splash());

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Agenda de Lembretes",
      home: ListaDeContatos(),
      //TelaEditaItensCad(), //CadastroContato(), //HomeScreen(),
    );
  }
}
