import 'dart:js';

import 'package:flutter/material.dart';
import 'package:ownftpclient/src/models/ftp_servers_model.dart';
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

  @override
  Widget build(BuildContext context) {

    _dataServer = ModalRoute.of(context).settings.arguments;

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

  Future<bool> _onBackPressed() {
    
    if( false ){
      print('Hola mundo!!');
    }else{
      _dataServer = null;
      Navigator.of(context).pop(true);
    }

  }

  _createListFiles() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot<List<FTPEntry>> snapshot){
        if( snapshot.hasData && _directory != snapshot.data){

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: ( 1 / .7 ),
            children: List.generate(snapshot.data.length, (index) => _itemWidget(context, snapshot.data[index])),
          );

        }else{

          return Center( child: CircularProgressIndicator())

        }
      }
    );
  }

  _itemWidget(BuildContext context, FTPEntry data) {}
}