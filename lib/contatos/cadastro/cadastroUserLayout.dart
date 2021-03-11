import 'dart:io';
import 'package:Agenda_de_Lembretes/contatos/UserCampos/user.dart';
import 'package:Agenda_de_Lembretes/contatos/lista/listaContatos.dart';
import 'package:Agenda_de_Lembretes/sql/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class BodyLayout extends StatefulWidget {
  @override
  _BodyLayoutState createState() => _BodyLayoutState();
}

class _BodyLayoutState extends State<BodyLayout> {
  //Exporta a imagem para o perfil do contato da Galeria
  Future getImageGalley() async {
    ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50)
        .then((file) {
      if (file == null) {
        return null;
      } else {
        setState(() {
          usee.image = file.path;
        });
      }
    });
  }

  //Tira uma foto com a camera do celular para a foto do perfil
  Future getImageCamera() async {
    ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50)
        .then((file) {
      if (file == null) {
        return null;
      } else {
        setState(() {
          usee.image = file.path;
        });
      }
    });
  }

  final formkey = GlobalKey<FormState>();
  var nome, telefone, endereco, email, cidade, uf, numero;

  //Inico do comando relacionado a Persistencia dos dados
  User usee = User();
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
  //Fim do comando

  final nomeFocus = FocusNode();
  final emailFocus = FocusNode();
  final telefoneFocus = FocusNode();
  final enderecoFocus = FocusNode();
  final cidadeFocus = FocusNode();
  final numeroFocus = FocusNode();
  final ufFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(usee.name != null && usee.name != ''
              ? usee.name
              : "Novo Contato"),
          centerTitle: true,
          backgroundColor: Colors.purple,
          leading: IconButton(
            icon: new Icon(Icons.arrow_back),
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                if (formkey.currentState.validate()) {
                  var form = formkey.currentState;
                  form.save();
                  await _dbHelper.insertContact(usee);
                  form.reset();
                  await _refreshContactList();
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ListContat();
                    },
                  ));
                }
              },
            ),
          ]),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Container(
                    height: 200,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: usee.image != null
                                ? FileImage(File(usee.image))
                                : AssetImage("asset/personS.png"))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton.extended(
                        heroTag: "bt3",
                        label: Text("Camera"),
                        hoverColor: Colors.cyan,
                        icon: Icon(Icons.camera_alt_outlined),
                        onPressed: () => getImageCamera(),
                      ),
                      Divider(
                        endIndent: 10,
                      ),
                      FloatingActionButton.extended(
                        heroTag: "bt4",
                        label: Text("Galeria"),
                        hoverColor: Colors.cyan,
                        icon: Icon(Icons.photo),
                        onPressed: () => getImageGalley(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.name,
                    onSaved: (value) => setState(() => usee.name = value),
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return "Digite um Nome ";
                      }
                      return null;
                    },
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    focusNode: nomeFocus,
                    onFieldSubmitted: (term) {
                      nomeFocus.unfocus();
                      FocusScope.of(context).requestFocus(telefoneFocus);
                    },
                    decoration: InputDecoration(
                      labelText: "Nome:",
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue, style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onChanged: (text) {
                      setState(() {
                        usee.name = text;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.phone,
                    onSaved: (String value) =>
                        setState(() => usee.phone = value),
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return "Digite um Telefone";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: telefoneFocus,
                    onFieldSubmitted: (term) {
                      telefoneFocus.unfocus();
                      FocusScope.of(context).requestFocus(emailFocus);
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
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => setState(() => usee.email = value),
                    textInputAction: TextInputAction.next,
                    focusNode: emailFocus,
                    onFieldSubmitted: (term) {
                      emailFocus.unfocus();
                      FocusScope.of(context).requestFocus(cidadeFocus);
                    },
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 140,
                        child: TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.text,
                          onSaved: (value) => setState(() => usee.city = value),
                          textInputAction: TextInputAction.next,
                          focusNode: cidadeFocus,
                          onFieldSubmitted: (term) {
                            cidadeFocus.unfocus();
                            FocusScope.of(context).requestFocus(ufFocus);
                          },
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
                      Divider(
                        endIndent: 10,
                      ),
                      Container(
                        width: 80, //MediaQuery.of(context).size.width,
                        child: TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          onSaved: (value) => setState(() => usee.uf = value),
                          textInputAction: TextInputAction.next,
                          focusNode: ufFocus,
                          onFieldSubmitted: (term) {
                            ufFocus.unfocus();
                            FocusScope.of(context).requestFocus(enderecoFocus);
                          },
                          validator: (String arg) {
                            if (arg.length >= 3) {
                              return 'Ex: Ce';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "UF:",
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 140,
                        child: TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          onSaved: (value) =>
                              setState(() => usee.address = value),
                          textInputAction: TextInputAction.next,
                          focusNode: enderecoFocus,
                          onFieldSubmitted: (term) {
                            enderecoFocus.unfocus();
                            FocusScope.of(context).requestFocus(numeroFocus);
                          },
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
                      Divider(
                        endIndent: 10,
                      ),
                      Container(
                        width: 80, //MediaQuery.of(context).size.width,
                        child: TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.streetAddress,
                          onSaved: (String value) =>
                              setState(() => usee.number = value),
                          focusNode: numeroFocus,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (term) {
                            numeroFocus.unfocus();
                            FocusScope.of(context).requestFocus();
                          },
                          decoration: InputDecoration(
                            labelText: "N°:",
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
