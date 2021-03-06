import 'package:Agenda_de_Lembretes/contatos/iconPerson/iconPerson.dart';
import 'package:Agenda_de_Lembretes/contatos/lista/listaContatos.dart';
import 'package:Agenda_de_Lembretes/notificacao/camposNotificar.dart';
import 'package:Agenda_de_Lembretes/sql/databaseNotificar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ListNotificarcao extends StatefulWidget {
  @override
  _ListNotificarcaoState createState() => _ListNotificarcaoState();
}

List<NotificarUsuario> notificarr = [];

class _ListNotificarcaoState extends State<ListNotificarcao> {
  DatabaseNotificar _dbNotific;

  @override
  void initState() {
    super.initState();
    _dbNotific = DatabaseNotificar.instance;
    _refreshContactList();
  }

  _refreshContactList() async {
    List<NotificarUsuario> y = await _dbNotific.fetchNotificar();
    setState(() {
      notificarr = y;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Lista de Lembretes",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    color: Colors.purple,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        //color: Colors.white,
                      ),
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 30,
                              right: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 100,
                    bottom: 50,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: notificarr.length,
                      itemBuilder: (context, index) {
                        final itens = notificarr[index].userNoti;
                        return Dismissible(
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) async {
                            //notificarr.removeAt(index);
                            await _dbNotific
                                .deleteNotificar(notificarr[index].id);
                            _refreshContactList();
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("$itens foi Removido")));
                              // Scaffold.of(context).showSnackBar(SnackBar(
                              //     content: Text("$itens foi Removido")));
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
                          child: Container(
                            child: ListTile(
                              leading: IconLembrete(),
                              title: Text(notificarr[index].userNoti),
                              subtitle:
                                  Text(notificarr[index].quandoNoti.toString()),
                            ),
                          ),
                          key: ObjectKey(notificarr[index]),
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
        label: Text("Lembretes"),
        backgroundColor: Colors.purple,
        icon: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ListContat();
              },
            ),
          );
        },
      ),
    );
  }
}
