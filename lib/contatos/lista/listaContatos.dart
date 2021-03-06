import 'package:Agenda_de_Lembretes/contatos/UserCampos/user.dart';
import 'package:Agenda_de_Lembretes/contatos/cadastro/cadastroUserLayout.dart';
import 'package:Agenda_de_Lembretes/contatos/iconPerson/iconPerson.dart';
import 'package:Agenda_de_Lembretes/contatos/visualizarContato/visualizarContato.dart';
import 'package:Agenda_de_Lembretes/notificacao/listaNotificacao.dart';
import 'package:Agenda_de_Lembretes/notificacao/notificar.dart';
import 'package:Agenda_de_Lembretes/sql/database.dart';
import 'package:flutter/material.dart';

class ListContat extends StatefulWidget {
  ListContat({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListContatcState createState() => new _ListContatcState();
}

// ignore: deprecated_member_use
List<User> contact1 = List<User>();

class _ListContatcState extends State<ListContat> {
  TextEditingController editingController = TextEditingController();

  DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    _refreshContactList();
  }

  _refreshContactList() async {
    List<User> x = await _dbHelper.fetchContacts();
    setState(() {
      contact1 = x;
    });
  }

  bool order = false; // Ordenar em ordem alfabeica

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Contatos",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ListNotificarcao();
                },
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
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
                          top: 20,
                          left: 2,
                          right: 2,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.sort_by_alpha),
                              onPressed: () {
                                setState(() {
                                  order = !order;
                                  if (order == true) {
                                    contact1.sort(
                                        (a, b) => a.name.compareTo(b.name));
                                  } else {
                                    contact1.sort(
                                        (a, b) => b.name.compareTo(a.name));
                                  }
                                });
                              },
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                  bottom: 10, left: 2, right: 40),
                              width: MediaQuery.of(context).size.width - 80,
                              height: 50,
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {});
                                },
                                controller: editingController,
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                  hintText: "Pesquisar Contato",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          BorderSide(color: Colors.purple)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: contact1.length,
                          itemBuilder: (context, index) {
                            if (editingController.text.isEmpty) {
                              final item = contact1[index].name;
                              return Dismissible(
                                onDismissed: (direction) {
                                  setState(() {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      setState(() {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Notificar(
                                              notificarUser: contact1[index],
                                            ),
                                          ),
                                        );
                                      });
                                    } else if (direction ==
                                        DismissDirection.startToEnd) {
                                      setState(() async {
                                        contact1.removeAt(index);
                                        await _dbHelper
                                            .deleteContact(contact1[index].id);
                                        _refreshContactList();
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "$item foi Removido")));
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
                                key: UniqueKey(),
                                child: Container(
                                  child: ListTile(
                                    leading: IconPerson(),
                                    title: Text(contact1[index].name),
                                    subtitle:
                                        Text(contact1[index].phone.toString()),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              VisualizarContato(
                                                  contact1[index]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else if (contact1[index]
                                .name
                                .toLowerCase()
                                .contains(editingController.text)) {
                              return ListTile(
                                leading: IconPerson(),
                                title: Text(contact1[index].name),
                                subtitle:
                                    Text(contact1[index].phone.toString()),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ])
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
    );
  }
}
