import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BodyLayout extends StatelessWidget {
  TextEditingController _controllerText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Form(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(fontWeight: FontWeight.bold),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    labelText: "Nome:",
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    /*focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(30),
                    ),*/
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
                //scrollPadding: EdgeInsets.all(25),
                style: TextStyle(fontWeight: FontWeight.bold),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Telefone:",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
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
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(10),
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
                      decoration: InputDecoration(labelText: "UF:"),
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
                      decoration: InputDecoration(labelText: "N°:"),
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
