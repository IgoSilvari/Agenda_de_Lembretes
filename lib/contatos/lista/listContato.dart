import 'package:Agenda_de_Lembretes/UserCampos/user.dart';
import 'package:Agenda_de_Lembretes/contatos/cadastro/cadastroUserLayout.dart';
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width - 160,
                                child: Text(
                                    ""), /*ListTile(
                                  leading: avatar,
                                  title: Text(contact[index]),
                                  subtitle: Text(contact[index]),
                                ),*/
                              ),
                              Padding(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () {},
                                  ),
                                ),
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
          Navigator.of(context).pop();
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
}
