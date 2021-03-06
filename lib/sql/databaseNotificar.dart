import 'dart:io';
import 'package:Agenda_de_Lembretes/notificacao/camposNotificar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseNoti {
  static const _databaseNotfic = 'DatabaseNotific.db';
  static const _databaseVersion = 1;

  //singleton class
  DatabaseNoti._();
  static final DatabaseNoti instance = DatabaseNoti._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseNotfic);
    print(dbPath);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    //create tables
    await db.execute(
        'CREATE TABLE ${NotificarUser.Notificartable}(${NotificarUser.colId} INTEGER PRIMARY KEY AUTOINCREMENT, ${NotificarUser.colNomeUser} TEXT, '
        '${NotificarUser.colquando} TEXT, ${NotificarUser.coltempo} TEXT)');
  }

  // inserir
  Future<int> insertContact(NotificarUser notificc) async {
    Database db = await database;
    return await db.insert(NotificarUser.Notificartable, notificc.toMap());
  }

//Atualizar
  Future<int> updateContact(NotificarUser notificc) async {
    Database db = await database;
    return await db.update(NotificarUser.Notificartable, notificc.toMap(),
        where: '${NotificarUser.colId}=?', whereArgs: [notificc.id]);
  }

//Deletar
  Future<int> deleteContact(int id) async {
    Database db = await database;
    return await db.delete(NotificarUser.Notificartable,
        where: '${NotificarUser.colId}=?', whereArgs: [id]);
  }

//contact - retrieve all
  Future<List<NotificarUser>> fetchContacts() async {
    Database db = await database;
    List<Map> notific = await db.query(NotificarUser.Notificartable);
    return notific.length == 0
        ? []
        : notific.map((x) => NotificarUser.fromMap(x)).toList();
  }
}
