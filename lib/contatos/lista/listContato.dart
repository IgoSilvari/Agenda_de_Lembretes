import 'package:Agenda_de_Lembretes/contatos/UserCampos/user.dart';
import 'package:Agenda_de_Lembretes/contatos/cadastro/cadastroUserLayout.dart';
import 'package:Agenda_de_Lembretes/contatos/visualizarContato/visualizarContato.dart';
import 'package:Agenda_de_Lembretes/notificacao/listaNotificacao.dart';
import 'package:Agenda_de_Lembretes/notificacao/notificar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListaDeContatos extends StatefulWidget {
  @override
  _ListaDeContatosState createState() => _ListaDeContatosState();
}

List<User> contact = List();

class _ListaDeContatosState extends State<ListaDeContatos> {
  final avatar = CircleAvatar(
    radius: 30,
    child: Icon(Icons.person),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Contatos",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomCenter,
                    color: Colors.purple,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: Colors.white,
                      ),
                      height: MediaQuery.of(context).size.height - 100,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 30,
                              right: 20,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: 10, left: 30, right: 2),
                                  width:
                                      MediaQuery.of(context).size.width - 110,
                                  height: 50,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                      hintText: "Pesquisar Contato",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.purple)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 3, right: 3),
                                  child: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Colors.purple,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 28,
                                        backgroundImage: NetworkImage(
                                          "https://image.freepik.com/vetores-gratis/cute-girl-gaming-holding-joystick-cartoon-icon-ilustracao-conceito-de-icone-de-tecnologia-de-pessoas-isolado-estilo-flat-cartoon_138676-2169.jpg",
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 150,
                      bottom: 50,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: contact.length,
                        itemBuilder: (context, index) {
                          final item = contact[index].name;
                          return Dismissible(
                            onDismissed: (direction) {
                              setState(() {
                                if (direction == DismissDirection.endToStart) {
                                  setState(() {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Notificar(
                                                notificarUser:
                                                    contact[index])));
                                  });
                                } else if (direction ==
                                    DismissDirection.startToEnd) {
                                  setState(() {
                                    contact.removeAt(index);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text("$item foi Removido")));
                                  });
                                }
                              });
                            },
                            background: Container(
                              color: Colors.red[300],
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.delete_sharp,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Deletar",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Colors.green,
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.notifications_active,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Lembrete",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            child: Container(
                              child: ListTile(
                                leading: avatar,
                                title: Text(contact[index].name),
                                subtitle: Text(contact[index].phone),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VisualizarContato(
                                                  contact[index])));
                                },
                              ),
                            ),
                            key: UniqueKey(),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Contatos"),
          icon: Icon(Icons.add),
          backgroundColor: Colors.purple,
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BodyLayout();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
