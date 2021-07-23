import 'dart:async';
import 'package:ownftpclient/src/utils/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators{

  /*
  ---EXEMPLE---
  nameServer: 'BlueExtend', 
  urlServer: '192.168.1.74', 
  initialDir: '/home/pi/BlueExtend/', 
  userServer: 'pi', 
  passwordServer: '59xNLVO0'
  */

  final _nameServerController = BehaviorSubject<String>();
  final _ipServerController = BehaviorSubject<String>();
  final _initialDirectionServerController = BehaviorSubject<String>();
  final _userServerController = BehaviorSubject<String>();
  final _passwordServerController = BehaviorSubject<String>();

  //Recupera los datos del Stream
  Stream<String> get nameServerStream => _nameServerController.stream.transform(isEmpty);
  Stream<String> get ipServerStream => _ipServerController.stream.transform(isIp);
  Stream<String> get initialDirectionStream => _initialDirectionServerController.stream.transform(isEmpty);
  Stream<String> get userServerStream => _userServerController.stream.transform(isEmpty);
  Stream<String> get passwordServerStream => _passwordServerController.stream.transform(isEmpty);

  Stream<bool> get formValidStream =>
    Rx.combineLatest5(
      nameServerStream, 
      ipServerStream, 
      initialDirectionStream, 
      userServerStream, 
      passwordServerStream, 
      (a, b, c, d, e) => true
    );

  //Insertar valores al Stream
  Function(String) get changeNameServer => _nameServerController.sink.add;
  Function(String) get changeIpServer => _ipServerController.sink.add;
  Function(String) get changeInitialDirectionServer => _initialDirectionServerController.sink.add;
  Function(String) get changeUserServer => _userServerController.sink.add;
  Function(String) get changePasswordServer => _passwordServerController.sink.add;

  //Obtener el ultimo valor ingresado a los stream
  String get name_server => _nameServerController.value;
  String get ip_server => _ipServerController.value;
  String get initial_direction_server => _initialDirectionServerController.value;
  String get user_server => _userServerController.value;
  String get password_server => _passwordServerController.value;

  dispose(){
    _nameServerController?.close();
    _ipServerController?.close();
    _initialDirectionServerController?.close();
    _userServerController?.close();
    _passwordServerController?.close();
  }

}