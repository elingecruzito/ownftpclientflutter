import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ownftpclient/src/bloc/directory_bloc.dart';
import 'package:ownftpclient/src/models/ftp_servers_model.dart';
import 'package:ownftpclient/src/provider/provider.dart';
import 'package:ownftpclient/src/utils/utils.dart';
import 'package:ftpconnect/ftpconnect.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({ Key key }) : super(key: key);

  @override
  _ServerPageState createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {

  FtpServers _dataServer;
  String _namePage;
  List<FTPEntry> _directory;
  DirectoryBloc _directoryBloc;

  @override
  Widget build(BuildContext context) {

    _dataServer = ModalRoute.of(context).settings.arguments;
    _directoryBloc = Provider.directoryBloc(context);

    _dataServer.g01CompleteDirectory = _dataServer.g01CompleteDirectory == null ?
                                      _dataServer.g01InitialDirectory :
                                      _dataServer.g01CompleteDirectory;

    _directoryBloc.loadDirectory(_dataServer);

    _namePage = _dataServer.g01LastDir == null ?
                _dataServer.g01Name :
                _dataServer.g01LastDir.replaceAll("/", "");
    
    return WillPopScope( // catch onBackPressed
      child: Scaffold(
        appBar: appBarCustom(_namePage),
        body: _createListFiles(),
      ), 
      onWillPop: _onBackPressed,
    );
  }

  Widget _createListFiles() {
    return StreamBuilder(
      key: Key(getRandString(Random().nextInt(9999))),
      stream: _directoryBloc.directorStream,
      builder: (BuildContext context, AsyncSnapshot<List<FTPEntry>> snapshot){
        if( snapshot.hasData && _directory != snapshot.data){
          _directory = snapshot.data;
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: ( 1 / .7 ),
            children: List.generate(snapshot.data.length, (index) => _itemWidget(context, snapshot.data[index])),
          );

        }else{

          return Center( child: CircularProgressIndicator());

        }
      }
    );
  }

  Widget _itemWidget(BuildContext context, FTPEntry data) {
    return InkWell(
      hoverColor: Colors.blueAccent,
      onTap: (){
        if( data.type == FTPEntryType.DIR ){
          setState(() {
            _dataServer.enterDirectory(data.name);            
          });
        }else{
          alert(context, data.name);
        }
      },
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Column(
          children: [
            Image(
              image: AssetImage(
                data.type == FTPEntryType.DIR ? 
                'assets/logo-folder.png' : 
                'assets/logo-file.png',
              ),
              width: 100.0,
              fit: BoxFit.cover,
            ),
            Text(data.name, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    
    if( _dataServer.g01InitialDirectory != _dataServer.g01CompleteDirectory && 
        _dataServer.g01CompleteDirectory != null){

          setState(() {
            _dataServer.onBack();      
          });
      
    }else{
      _dataServer = null;
      _directory.clear();
      // _directoryBloc.disponse();
      Navigator.of(context).pop(true);
    }

  }
}