import 'dart:io';

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
        ''');
      }
    );

  }

}