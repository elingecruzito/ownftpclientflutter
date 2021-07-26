import 'package:flutter/material.dart';

AppBar appBarCustom(String title){
  return AppBar(
    title: Center(child: Text(title, style: TextStyle(color: Colors.black))),
    elevation: 10.0,
    backgroundColor: Colors.white,
  );
}