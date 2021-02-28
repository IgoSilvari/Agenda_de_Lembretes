import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String city;
  final String uf;
  final String address;
  final String number;
  //final File image;

  const User({
    this.id,
    @required this.name,
    @required this.phone,
    this.email,
    this.city,
    this.uf,
    this.address,
    this.number,
    //this.image,
  });
}
