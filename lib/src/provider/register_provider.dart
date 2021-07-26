import 'package:flutter/cupertino.dart';
import 'package:ownftpclient/src/bloc/register_bloc.dart';
import 'package:ownftpclient/src/models/ftp_servers_model.dart';
import 'package:ownftpclient/src/provider/db_provider.dart';

class RegisterProvider extends ChangeNotifier{

  List<FtpServers> servers = [];

  Future<bool> addServer(RegisterBloc registerBloc) async{

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

  loadServers() async{
    final servers = await DbProvider.db.getAllServers();
    this.servers = [...servers];
    notifyListeners();
  }

  Future<bool> deleteServer(int id) async{
    final res = await DbProvider.db.deleteServer(id);
    if( !res.isNaN ){
      this.loadServers();
      return true;
    }
    return false;
  }

}