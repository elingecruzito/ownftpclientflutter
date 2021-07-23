import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addServer(),
    );
  }

  Widget _addServer() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.lightBlue,
      onPressed: () => Navigator.pushNamed(context, 'register')
    );
  }
}