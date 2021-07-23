import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _padding_lr = 20.0;
  final _padding_tb = 250.0;
  final Color _color_icons = Colors.lightBlue;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(_padding_lr, _padding_tb, _padding_lr, _padding_tb),
          child: Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  _fieldNameServer(),
                  _fieldServer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldNameServer() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.all_inbox, color: _color_icons),
              labelText: 'Name server:',
              counter: snapshot.data,
              errorText: snapshot.error,
            ),
          ),
        );
      }
    );
  }

  Widget _fieldServer() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.wifi, color: _color_icons),
              labelText: 'Ip server:',
              counter: snapshot.data,
              errorText: snapshot.error
            ),
          ),
        );
      }
    );
  }
}