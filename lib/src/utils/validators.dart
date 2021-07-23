import 'dart:async';

class Validators{
  
  final isEmpty = StreamTransformer<String, String>.fromHandlers(
    handleData: (txt, sink){
      if( !txt.isEmpty ){
        sink.add(txt);
      }else{
        sink.addError("El valor no debe de estar vacio!");
      }
    }
  );

  final isIp = StreamTransformer<String, String>.fromHandlers(
    handleData: (ip, sink){
      
      if( RegExp(r"^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$", caseSensitive: false, multiLine: false).hasMatch(ip) ){
        sink.add(ip);
      }else{
        sink.addError("La IP tiene un formato incorrecto!");
      }
    }
  );
}