import 'package:flutter/material.dart';
import 'package:ownftpclient/src/bloc/register_bloc.dart';
import 'package:ownftpclient/src/provider/provider.dart';

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

    final registerBloc = Provider.registerBloc(context);

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
                  _fieldNameServer(registerBloc),
                  SizedBox(height: 10.0),
                  _fieldServer(registerBloc),
                  SizedBox(height: 30.0),
                  _buttomSubmit(registerBloc)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldNameServer(RegisterBloc registerBloc) {
    return StreamBuilder(
      stream: registerBloc.nameServerStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.all_inbox, color: _color_icons),
              labelText: 'Name server:',
              errorText: snapshot.error,
            ),
            onChanged: registerBloc.changeNameServer,
          ),
        );
      }
    );
  }

  Widget _fieldServer(RegisterBloc registerBloc) {
    return StreamBuilder(
      stream: registerBloc.ipServerStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.wifi, color: _color_icons),
              labelText: 'Ip server:',
              errorText: snapshot.error
            ),
            onChanged: registerBloc.changeIpServer,
          ),
        );
      }
    );
  }

  Widget _buttomSubmit(RegisterBloc registerBloc) {
    return StreamBuilder(
      stream: registerBloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
            child: Text('Enviar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: _color_icons,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=> _register(context, registerBloc) : null
        );
      }
    );
  }

  _register(BuildContext context, RegisterBloc registerBloc) {
    print('Register');
  }
}