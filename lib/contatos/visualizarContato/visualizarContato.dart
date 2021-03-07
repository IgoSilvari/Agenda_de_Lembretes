import 'dart:io';

import 'package:Agenda_de_Lembretes/contatos/UserCampos/user.dart';
import 'package:Agenda_de_Lembretes/contatos/iconPerson/iconPerson.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class VisualizarContato extends StatefulWidget {
  final User use;
  VisualizarContato(this.use);

  @override
  _VisualizarContatoState createState() => _VisualizarContatoState();
}

class _VisualizarContatoState extends State<VisualizarContato> {
  void chamar() async {
    if (widget.use.phone.toString().length >= 9 &&
        widget.use.phone.toString().length <= 11) {
      var url = "tel:" + widget.use.phone.toString();
      print(url);
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      return null;
    }
  }

  bool favorit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.use.name),
        actions: [
          IconButton(
            icon: favorit
                ? Icon(Icons.star)
                : Icon(
                    Icons.star_outlined,
                    color: Colors.yellow,
                  ),
            onPressed: () {
              setState(() {
                favorit = !favorit;
              });
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    height: 250,
                    width: 150,
                    decoration: BoxDecoration(
                      //color: Colors.purple,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: widget.use.image != null
                            ? FileImage(File(widget.use.image))
                            : AssetImage("asset/personS.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 15, left: 15),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.use.name,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400]),
                    ),
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
                          onPressed: chamar,
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => TelaEditaItensCad(User(
                            //         name: 'nome1',
                            //         phone: 'telefone2',
                            //         id: 'id')),
                            //   ),
                            // );
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
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[400])),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.use.phone.toString()),
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
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[400])),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.use.email),
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
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[400])),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.use.address +
                                "," +
                                " " +
                                widget.use.number.toString() +
                                "," +
                                " " +
                                widget.use.city +
                                "," +
                                widget.use.uf),
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
