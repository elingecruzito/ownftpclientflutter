import 'dart:async';

class Validators{
  final isEmpty = StreamTransformer<String, String>.fromHandlers(
    handleData: (txt, sink){
      if( txt.isEmpty ){
        sink.add(txt);
      }else{
        sink.addError("El valor no debe de estar vacio!");
      }
    }
  );

  final isIp = StreamTransformer<String, String>.fromHandlers(
    handleData: (ip, sink){
      if( RegExp(r"/^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/").hasMatch(ip)){
        sink.add(ip);
      }else{
        sink.addError("La IP tiene un formato incorrecto!");
      }
    }
  );
}