import 'package:flutter/material.dart';

//Tinha muitas telas usando o CiclerAvatar, trouxe para deixar centralizado
class IconPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      child: Icon(Icons.person),
    );
  }
}

//Esse Widget é da lista de Lembrete
class IconLembrete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      backgroundColor: Colors.white,
      backgroundImage: NetworkImage(
        "https://image.freepik.com/fotos-gratis/pino-colorido-do-papel-de-nota-com-clipes-de-papel-azuis-e-isolado-no-branco_211682-109.jpg",
      ),
    );
  }
}
