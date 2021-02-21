import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String city;
  final String uf;
  final String address;
  final String number;

  const User({
    this.id,
    @required this.name,
    @required this.phone,
    this.email,
    this.city,
    this.uf,
    this.address,
    this.number,
  });
}