import 'dart:io';
import 'package:Agenda_de_Lembretes/UserCampos/user.dart';
import 'package:Agenda_de_Lembretes/contatos/lista/listContato.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BodyLayout extends StatefulWidget {
  @override
  _BodyLayoutState createState() => _BodyLayoutState();
}

class _BodyLayoutState extends State<BodyLayout> {
  final avatar = CircleAvatar(
    radius: 30,
    child: Icon(Icons.person),
  );

  File _image;

  //Exporta a imagem para o perfil do contato da Galeria
  Future getImageGalley() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  //Tira uma foto com a camera do celular para a foto do perfil
  Future getImageCamera() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  final formkey = GlobalKey<FormState>();

  final Map<String, Object> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        leading: Builder(
          builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ListaDeContatos();
                  }),
                );
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (formkey.currentState.validate()) {
                setState(() {
                  formkey.currentState.save();

                  contact.add(_formData['nome']);
                  contact.add(_formData['telefone']);

                  User(
                      id: _formData['id'],
                      name: _formData['nome'],
                      phone: _formData['telefone'],
                      address: _formData['endereco'],
                      city: _formData['cidade'],
                      email: _formData['email'],
                      number: _formData['numero'],
                      uf: _formData['UF']);
                });

                /*User(
                    id: _formData['id'],
                    name: _formData['nome'],
                    phone: _formData['telefone'],
                    address: _formData['endereco'],
                    city: _formData['cidade'],
                    email: _formData['email'],
                    number: _formData['numero'],
                    uf: _formData['UF']);*/

                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ListaDeContatos();
                  },
                ));
              }
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(15),
        child: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 100,
                  width: 100,
                  child: _image == null
                      ? avatar
                      : Image.file(
                          _image,
                        ),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton.icon(
                      icon: Icon(Icons.camera_alt_outlined),
                      label: Text(
                        "Camera",
                        style: TextStyle(fontSize: 20),
                      ),
                      padding: EdgeInsets.only(right: 10, left: 15),
                      onPressed: () => getImageCamera(),
                    ),
                    Divider(
                      endIndent: 10,
                    ),
                    RaisedButton.icon(
                      icon: Icon(Icons.photo),
                      label: Text(
                        "Galeria",
                        style: TextStyle(fontSize: 20),
                      ),
                      padding: EdgeInsets.only(right: 10, left: 15),
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
                  onSaved: (value) => _formData['nome'] = value,
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
                padding: EdgeInsets.all(7),
                child: TextFormField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => _formData['telefone'] = value,
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
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  //controller: cEmail,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => _formData['Email'] = value,
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
                        onSaved: (value) => _formData['Cidade'] = value,
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
                        onSaved: (value) => _formData['UF'] = value,
                        validator: (val) => val.length > 3
                            ? "Digite as Siglas do seu Estado"
                            : null,
                        keyboardType: TextInputType.streetAddress,
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
                        onSaved: (value) => _formData['Endereco'] = value,
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
                        onSaved: (value) => _formData['Numero'] = value,
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
    );
  }
}
