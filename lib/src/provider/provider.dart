import 'package:flutter/material.dart';
import 'package:ownftpclient/src/bloc/register_bloc.dart';

class Provider extends InheritedWidget{

  final _registerBloc = new RegisterBloc();
  
  static Provider _instancia;

  factory Provider({Key key, Widget child}){
    if( _instancia == null ){
      _instancia = new Provider._internal( key: key, child: child );
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static RegisterBloc registerBloc(BuildContext context) 
    => context.dependOnInheritedWidgetOfExactType<Provider>()._registerBloc;
}