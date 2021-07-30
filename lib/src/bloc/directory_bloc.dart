import 'package:ftpconnect/ftpconnect.dart';
import 'package:ownftpclient/src/models/ftp_servers_model.dart';
import 'package:ownftpclient/src/provider/directory_provider.dart';
import 'package:rxdart/subjects.dart';

class DirectoryBloc{

  final _directoryController = new BehaviorSubject<List<FTPEntry>>();

  final _directoryProvider = new DirectoryProvider();

  Stream<List<FTPEntry>> get directorStream => _directoryController;

  void loadDirectory(FtpServers _dataServer) async{
    final _listDirectory = await _directoryProvider.getDirectoryCurrent(_dataServer);
    print(_listDirectory);
    _directoryController.sink.add(_listDirectory);
  }

  disponse(){
    _directoryController?.close();
  }

}