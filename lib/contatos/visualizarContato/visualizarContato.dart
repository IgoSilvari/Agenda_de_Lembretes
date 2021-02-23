import 'package:Agenda_de_Lembretes/contatos/UserCampos/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class VisualizarContato extends StatelessWidget {
  final User use;
  VisualizarContato(this.use);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(use.name),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  padding: EdgeInsets.all(35),
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  child: Icon(Icons.person, color: Colors.white, size: 25),
                  decoration: BoxDecoration(
                    color: Colors.teal[100],
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ],
          ),
          Container(
            //padding: EdgeInsets.all(2),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 15, left: 15),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    use.name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]),
                  ),
                  //color: Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      FlatButton.icon(
                        icon: Icon(
                          Icons.phone_outlined,
                          size: 30,
                        ),
                        label: Text("Ligar"),
                        textColor: Colors.blue[700],
                        padding: EdgeInsets.only(
                            left: 25, top: 10, bottom: 10, right: 20),
                        onPressed: () {},
                      ),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.edit,
                          size: 30,
                        ),
                        label: Text("Editar"),
                        textColor: Colors.blue[700],
                        padding: EdgeInsets.only(
                            left: 25, top: 10, bottom: 10, right: 20),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisualizarContato(
                                User(
                                    name: 'nome1',
                                    phone: 'telefone2',
                                    id: 'id'),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(13),
                      child: Icon(Icons.phone_outlined),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 65,
                      height: 80,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.grey[400])),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(use.phone),
                          Divider(height: 5, color: Colors.white),
                          Text(
                            "Celular",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(13),
                      child: Icon(Icons.email_outlined),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 65,
                      height: 80,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.grey[400])),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(use.email),
                          Divider(
                            height: 5,
                            color: Colors.white,
                          ),
                          Text(
                            "E-mail",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(13),
                      child: Icon(Icons.location_city_rounded),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 65,
                      height: 90,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.grey[400])),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(use.address +
                              "," +
                              " " +
                              use.number +
                              "," +
                              " " +
                              use.city +
                              "," +
                              use.uf),
                          Divider(
                            height: 5,
                            color: Colors.white,
                          ),
                          Text(
                            "Endereço",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
