import 'package:flutter/cupertino.dart';
import 'package:ownftpclient/src/bloc/register_bloc.dart';
import 'package:ownftpclient/src/models/ftp_servers_model.dart';
import 'package:ownftpclient/src/provider/db_provider.dart';

class RegisterProvider extends ChangeNotifier{

  Future<bool> addServer(RegisterBloc registerBloc) async{

    /*
    g01_name TEXT,
    g01_ip TEXT,
    g01_initial_directory TEXT,
    g01_user TEXT,
    g01_password TEXT
    */

    final ftpServer = new FtpServers();
    ftpServer.g01Name = registerBloc.name_server;
    ftpServer.g01Ip = registerBloc.ip_server;
    ftpServer.g01InitialDirectory = registerBloc.initial_direction_server;
    ftpServer.g01User = registerBloc.user_server;
    ftpServer.g01Password = registerBloc.password_server;

    final newId = await DbProvider.db.addServer(ftpServer);
    
    if( newId.isNaN ){
      return false;
    }
    return true;
  }

}