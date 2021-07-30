import 'package:ftpconnect/ftpconnect.dart';
import 'package:ownftpclient/src/models/ftp_servers_model.dart';

class DirectoryProvider{

  List<FTPEntry> _listDirectory;
  FTPConnect ftpConnect;

  Future<List<FTPEntry>> getDirectoryCurrent(FtpServers dataserver) async{
    ftpConnect = FTPConnect(
                              dataserver.g01Ip, 
                              user: dataserver.g01User,
                              pass: dataserver.g01Password
                            );
    await ftpConnect.connect();
    await ftpConnect.changeDirectory(dataserver.g01CompleteDirectory);
    _listDirectory = await ftpConnect.listDirectoryContent(cmd: DIR_LIST_COMMAND.LIST);
    await ftpConnect.disconnect();

    return _listDirectory;

  }
}