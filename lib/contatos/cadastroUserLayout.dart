import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class BodyLayout extends StatefulWidget {
  @override
  _BodyLayoutState createState() => _BodyLayoutState();
}

class _BodyLayoutState extends State<BodyLayout> {
  final avatar = CircleAvatar(
    radius: 30,
    child: Icon(Icons.person),
  );

  TextEditingController _controllerText = TextEditingController();

  File _image;

  Future getImageGalley() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future getImageCamera() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(15),
      child: Form(
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
                        fit: BoxFit.fill,
                        width: 100,
                        height: 100,
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
    );
  }
}
