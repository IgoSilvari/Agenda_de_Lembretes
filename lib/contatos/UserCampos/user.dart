import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User {
  static const contatotable = 'contacts';
  static const colId = 'id';
  static const colNome = 'name';
  static const colphone = 'phone';
  static const colemail = 'email';
  static const colcity = 'city';
  static const coluf = 'uf';
  static const coladdress = 'address';
  static const colnumber = 'number';
  static const colimage = 'image';

  int id;
  String name;
  String email;
  var phone;
  String city;
  String uf;
  String address;
  var number;
  String image;

  User({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.city,
    this.uf,
    this.address,
    this.number,
    this.image,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'city': city,
      'uf': uf,
      'address': address,
      'number': number,
      'image': image,
    };
    if (id != null) {
      map[colId] = id;
    }
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    name = map[colNome];
    phone = map[colphone];
    email = map[colemail];
    city = map[colcity];
    uf = map[coluf];
    address = map[coladdress];
    number = map[colnumber];
    image = map[colimage];
  }
}
