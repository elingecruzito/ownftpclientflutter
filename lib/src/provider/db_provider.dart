import 'dart:io';

import 'package:ownftpclient/src/models/ftp_servers_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider{

  static Database _database;
  static final DbProvider db = DbProvider._();
  DbProvider._();

  Future<Database> get database async{
    if( _database != null ) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async{

    //Direccion de donde se alamacenara la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'db_ownftpclient.db');
    print(path);

    //Crea la base de datos
    return await openDatabase(
      path,
      version: 1, 
      onOpen: (db){ },
      onCreate: (Database db, int version) async{
        await db.execute('''
          CREATE TABLE g01_ftp_servers(
            g01_id INTEGER PRIMARY KEY,
            g01_name TEXT,
            g01_ip TEXT,
            g01_initial_directory TEXT,
            g01_user TEXT,
            g01_password TEXT
          )
        ''');
      }
    );

  }

  Future<int> addServer(FtpServers ftpServer) async{
    final db = await database;
    final res = await db.insert('g01_ftp_servers', ftpServer.toJson() );

    return res;
  }

  Future<List<FtpServers>> getAllServers() async {
    final db = await database;
    final res = await db.query('g01_ftp_servers');

    return res.isNotEmpty
          ? res.map((e) => FtpServers.fromJson(e)).toList()
          : [];
  }

  Future<int> deleteServer(int id) async{
    final db = await database;
    final res = db.delete('g01_ftp_servers', where: 'g01_id = ?', whereArgs: [id]);

    return res;
  }

}