import 'package:Agenda_de_Lembretes/UserCampos/user.dart';
import 'package:Agenda_de_Lembretes/contatos/cadastro/cadastroUserLayout.dart';
import 'package:Agenda_de_Lembretes/contatos/lista/menu_editar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
    return Scaffold(
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
      body: Column(
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
                            //Text("Status"),
                            Container(
                              padding: EdgeInsets.only(
                                  bottom: 10, left: 30, right: 2),
                              width: MediaQuery.of(context).size.width - 110,
                              height: 50,
                              child: TextField(
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
                            Padding(
                              padding: const EdgeInsets.only(left: 3, right: 3),
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
                                        "https://image.freepik.com/vetores-gratis/cute-girl-gaming-holding-joystick-cartoon-icon-ilustracao-conceito-de-icone-de-tecnologia-de-pessoas-isolado-estilo-flat-cartoon_138676-2169.jpg"),
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
                  //padding: EdgeInsets.only(bottom: 50),
                  height: MediaQuery.of(context).size.height - 300,
                  child: ListView.builder(
                    itemCount: contact.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: ListTile(
                          leading: avatar,
                          title: Text(contact[index].name),
                          subtitle: Text(contact[index].phone),
                        ),
                        children: <Widget>[
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.email,
                                        color: Colors.purple,
                                      ),
                                      Text(" " + contact[index].email,
                                          style: TextStyle(
                                              //color: Colors.purple[100],
                                              fontSize: 15)),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.home),
                                      Text(" " + contact[index].address,
                                          style: TextStyle(
                                              //color: Colors.purple[100],
                                              fontSize: 15)),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.location_city_rounded),
                                      Text(" " + contact[index].city,
                                          style: TextStyle(
                                              //color: Colors.purple[100],
                                              fontSize: 15)),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 5, top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text("N°:",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        Text(" " + contact[index].number,
                                            style: TextStyle(
                                                //color: Colors.purple[100],
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("UF:",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        Text(" " + contact[index].uf,
                                            style: TextStyle(
                                                //color: Colors.purple[100],
                                                fontSize: 15)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(2),
                                child: pop(),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BodyLayout(); //CadastroContato();
              },
            ),
          );
        },
      ),
    );
  }

  pop() {
    return PopupMenuButton(
      onSelected: chamarLista,
      itemBuilder: (BuildContext context) {
        return Menu.escolher.map((String escolher) {
          return PopupMenuItem(
            value: escolher,
            child: Text(escolher),
          );
        }).toList();
      },
    );
  }

  chamarLista(String value) {
    print(value);
  }
}
