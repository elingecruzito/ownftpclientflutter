import 'dart:async';
import 'package:ownftpclient/src/utils/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators{

  final _nameServerController = BehaviorSubject<String>();
  final _ipServerController = BehaviorSubject<String>();

  //Recupera los datos del Stream
  Stream<String> get nameServerStream => _nameServerController.stream.transform(isEmpty);
  Stream<String> get ipServerStream => _ipServerController.stream.transform(isIp);

  Stream<bool> get formValidStream =>
    Rx.combineLatest2(nameServerStream, ipServerStream, (a, b) => true);

  //Insertar valores al Stream
  Function(String) get changeNameServer => _nameServerController.sink.add;
  Function(String) get changeIpServer => _ipServerController.sink.add;

  //Obtener el ultimo valor ingresado a los stream
  String get name_server => _nameServerController.value;
  String get ip_server => _ipServerController.value;

  dispose(){
    _nameServerController?.close();
    _ipServerController?.close();
  }

}