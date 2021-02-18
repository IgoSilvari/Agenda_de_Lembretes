import 'package:Agenda_de_Lembretes/contatos/cadastroUser.dart';
import 'package:Agenda_de_Lembretes/contatos/listContato.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homescreen.dart';

void main() => runApp(Splash());

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Agenda de Lembretes",
        home: ListaDeContatos() //CadastroContato(), //HomeScreen(),
        );
  }
}
