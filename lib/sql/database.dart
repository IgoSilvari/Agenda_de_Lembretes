import 'dart:io';
import 'package:Agenda_de_Lembretes/notificacao/camposNotificar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:Agenda_de_Lembretes/contatos/UserCampos/user.dart';

class DatabaseHelper {
  static const _databaseName = 'ContactDatabase.db';
  static const _databaseVersion = 1;

  //singleton class
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    print(dbPath);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    //create tables
    await db.execute(
        'CREATE TABLE ${User.contatotable}(${User.colId} INTEGER PRIMARY KEY AUTOINCREMENT, ${User.colNome} TEXT, '
        '${User.coladdress} TEXT, ${User.colcity} TEXT, ${User.colemail} TEXT, ${User.colnumber} INTEGER, ${User.colphone} INTEGER, ${User.coluf} TEXT, ${User.colimage} TEXT)');
  }

  // inserir
  Future<int> insertContact(User contact) async {
    Database db = await database;
    return await db.insert(User.contatotable, contact.toMap());
  }

//Atualizar
  Future<int> updateContact(User contact) async {
    Database db = await database;
    return await db.update(User.contatotable, contact.toMap(),
        where: '${User.colId}=?', whereArgs: [contact.id]);
  }

//Deletar
  Future<int> deleteContact(int id) async {
    Database db = await database;
    return await db
        .delete(User.contatotable, where: '${User.colId}=?', whereArgs: [id]);
  }

//contact - retrieve all
  Future<List<User>> fetchContacts() async {
    Database db = await database;
    List<Map> contacts = await db.query(User.contatotable);
    return contacts.length == 0
        ? []
        : contacts.map((x) => User.fromMap(x)).toList();
  }
}
