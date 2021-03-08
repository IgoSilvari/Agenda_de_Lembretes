import 'dart:io';
import 'package:Agenda_de_Lembretes/contatos/UserCampos/user.dart';
import 'package:Agenda_de_Lembretes/contatos/lista/listaContatos.dart';
import 'package:Agenda_de_Lembretes/sql/database.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
                      color:
                          widget.use.image == null ? Colors.white : Colors.blue,
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
                            openEditDialog();
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

  //Editar Informações dos contatos

  //Exporta a imagem para o perfil do contato da Galeria
  Future getImageGalley() async {
    ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
      if (file == null) {
        return null;
      } else {
        setState(() {
          widget.use.image = file.path;
        });
      }
    });
  }

  //Tira uma foto com a camera do celular para a foto do perfil
  Future getImageCamera() async {
    ImagePicker.pickImage(source: ImageSource.camera).then((file) {
      if (file == null) {
        return null;
      } else {
        setState(() {
          widget.use.image = file.path;
        });
      }
    });
  }

  _refreshContactList() async {
    List<User> x = await _dbHelper.fetchContacts();
    setState(() {
      contact1 = x;
    });
  }

  final formkey = GlobalKey<FormState>();
  DatabaseHelper _dbHelper;

  TextEditingController nameController;
  TextEditingController telefoneController;
  TextEditingController emailController;
  TextEditingController cidadeController;
  TextEditingController ufController;
  TextEditingController ederecoController;
  TextEditingController numeroController;
  //TextEditingController tname = TextEditingController();

  iniState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    _refreshContactList();
  }

  openEditDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(3),
                      child: Container(
                        height: 160,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: widget.use.image != null
                                    ? FileImage(File(widget.use.image))
                                    : AssetImage("asset/personS.png"))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton.extended(
                            heroTag: "bt5",
                            label: Text("Camera"),
                            hoverColor: Colors.purple,
                            icon: Icon(Icons.camera_alt_outlined),
                            onPressed: () => getImageCamera(),
                          ),
                          Divider(
                            endIndent: 10,
                          ),
                          FloatingActionButton.extended(
                            heroTag: "bt6",
                            label: Text("Galeria"),
                            hoverColor: Colors.purple,
                            icon: Icon(Icons.photo),
                            onPressed: () => getImageGalley(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: nameController,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.name,
                        // onSaved: (value) => setState(() {
                        //   teste.name = value;
                        // }),
                        // onChanged: (text) {
                        //   setState(() {
                        //     tname = text;
                        //   });
                        // },
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return "Digite um Nome ";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Nome:",
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(30),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        controller: telefoneController,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.phone,
                        //onSaved: (value) => telefoneEd = (value),
                        onChanged: (text) {
                          setState(() {
                            //teste.number = text;
                          });
                        },
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return "Digite um Telefone";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Telefone:",
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(30),
                            )),
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(11),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        //initialValue: emailEd,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.emailAddress,
                        // onSaved: (value) => emailEd = (value),
                        decoration: InputDecoration(
                          labelText: "E-mail:",
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 120,
                        child: TextFormField(
                          // initialValue: cidadeEd,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.text,
                          //: (value) => cidadeEd = (value),
                          decoration: InputDecoration(
                            labelText: "Cidade:",
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 120,
                        child: TextFormField(
                          // initialValue: enderecoEd,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          // onSaved: (value) => enderecoEd = (value),
                          decoration: InputDecoration(
                            labelText: "Endereço:",
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Container(
                            width: 110, //MediaQuery.of(context).size.width,
                            child: TextFormField(
                              // initialValue: numeroEd,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.streetAddress,
                              //  onSaved: (value) => numeroEd = (value),
                              decoration: InputDecoration(
                                labelText: "N°:",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 10, 20, 10),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          Divider(indent: 5),
                          Container(
                            width: 100, //MediaQuery.of(context).size.width,
                            child: TextFormField(
                              // initialValue: ufEd,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              // onSaved: (value) => ufEd = (value),
                              validator: (String arg) {
                                if (arg.length >= 3) {
                                  return 'Sigla do Estado';
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "UF:",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 10, 20, 10),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          FloatingActionButton.extended(
                            heroTag: "bt1",
                            label: Text("Salvar"),
                            hoverColor: Colors.cyan,
                            icon: Icon(Icons.save_outlined),
                            onPressed: () async {
                              // if (formkey.currentState.validate()) {
                              //   var form = formkey.currentState;
                              //   form.save();
                              //   //await _dbHelper.updateContact();
                              //   form.reset();
                              //   await _refreshContactList();
                              //   Navigator.of(context).pop();
                              // }
                            },
                          ),
                          Divider(indent: 10),
                          FloatingActionButton.extended(
                            backgroundColor: Colors.red,
                            heroTag: "bt2",
                            label: Text("Cancelar"),
                            hoverColor: Colors.cyan,
                            icon: Icon(Icons.cancel_outlined),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
