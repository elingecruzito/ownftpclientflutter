import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

AppBar appBarCustom(String title){
  return AppBar(
    title: Center(child: Text(title, style: TextStyle(color: Colors.black))),
    elevation: 10.0,
    backgroundColor: Colors.white,
  );
}


void alert(BuildContext context, String msj){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msj)
    )
  );
}

String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) =>  random.nextInt(255));
  return base64UrlEncode(values);
}