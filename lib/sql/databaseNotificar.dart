import 'dart:io';
import 'package:Agenda_de_Lembretes/notificacao/camposNotificar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseNotificar {
  static const _databaseNotifi = 'DatabaseNotific.db';
  static const _databaseVersion = 1;

  //singleton class
  DatabaseNotificar._();
  static final DatabaseNotificar instance = DatabaseNotificar._();

  Database _databasee;
  Future<Database> get database async {
    if (_databasee != null) return _databasee;
    _databasee = await _initDatabase();
    return _databasee;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseNotifi);
    print(dbPath);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _oncreate);
  }

  //create tables
  Future _oncreate(Database dbl, int version) async {
    await dbl.execute(
        'CREATE TABLE ${NotificarUsuario.Notificatable}(${NotificarUsuario.colunId} INTEGER PRIMARY KEY AUTOINCREMENT, ${NotificarUsuario.colunNomeUser} TEXT, '
        '${NotificarUsuario.colunquando} TEXT, ${NotificarUsuario.coluntempo} TEXT)');
  }

  // inserir
  Future<int> insertNotificar(NotificarUsuario notificar) async {
    Database dbl = await database;
    return await dbl.insert(NotificarUsuario.Notificatable, notificar.toMap());
  }

//Atualizar
  Future<int> updateNotificar(NotificarUsuario notificar) async {
    Database dbl = await database;
    return await dbl.update(NotificarUsuario.Notificatable, notificar.toMap(),
        where: '${NotificarUsuario.colunId}=?', whereArgs: [notificar.id]);
  }

//Deletar
  Future<int> deleteNotificar(int id) async {
    Database dbl = await database;
    return await dbl.delete(NotificarUsuario.Notificatable,
        where: '${NotificarUsuario.colunId}=?', whereArgs: [id]);
  }

//contact - retrieve all
  Future<List<NotificarUsuario>> fetchNotificar() async {
    Database dbl = await database;
    List<Map> notificar = await dbl.query(NotificarUsuario.Notificatable);
    return notificar.length == 0
        ? []
        : notificar.map((x) => NotificarUsuario.fromMap(x)).toList();
  }
}









// class DatabaseNotifi {
//   static const _databaseNotific = 'DatabaseNotific.db';
//   static const _databaseVersion = 1;

//   //singleton class
//   DatabaseNotificar._();
//   static final DatabaseNotificar instance = DatabaseNotificar._();

//   Database _database;
//   Future<Database> get database async {
//     if (_database != null) return _database;
//     _database = await _initDatabase();
//     return _database;
//   }

//   _initDatabase() async {
//     Directory dataDirectory = await getApplicationDocumentsDirectory();
//     String dbPath = join(dataDirectory.path, _databaseNotific);
//     print(dbPath);
//     return await openDatabase(dbPath,
//         version: _databaseVersion, onCreate: _onCreateDB);
//   }

//   //create tables
//   Future _onCreateDB(Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE ${NotificarUser.Notificatable} ( ${NotificarUser.coluId} INTEGER PRIMARY KEY AUTOINCREMENT, ${NotificarUser.colNomeUser} TEXT, '
//         '${NotificarUser.colquando} TEXT, ${NotificarUser.coltempo} TEXT)');
//   }

//   // inserir
//   Future<int> insertNotificar(NotificarUser notificar) async {
//     Database db = await database;
//     return await db.insert(NotificarUser.Notificatable, notificar.toMap());
//   }

// //Atualizar
//   Future<int> updateNotificar(NotificarUser notificar) async {
//     Database db = await database;
//     return await db.update(NotificarUser.Notificatable, notificar.toMap(),
//         where: '${NotificarUser.coluId}=?', whereArgs: [notificar.idNotific]);
//   }

// //Deletar
//   Future<int> deleteNotificar(int idNotific) async {
//     Database db = await database;
//     return await db.delete(NotificarUser.Notificatable,
//         where: '${NotificarUser.coluId}=?', whereArgs: [idNotific]);
//   }

// //contact - retrieve all
//   Future<List<NotificarUser>> fetchNotificar() async {
//     Database db = await database;
//     List<Map> notificar = await db.query(NotificarUser.Notificatable);
//     return notificar.length == 0
//         ? []
//         : notificar.map((x) => NotificarUser.fromMap(x)).toList();
//   }
// }