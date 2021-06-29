import 'package:http/http.dart' as http;
import 'package:kate_botique_app/routes/sqlite_conn.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
//  Map<String, String> headers = {
//    'Content-type': 'application/x-www-form-urlencoded',
//    'Accept': 'application/json'
//  };
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };


  String _baseUrl = 'http://10.0.2.2:8000/api';
  DatabaseConnection _connection;
  httpGet(String api) async {
    return await http.get(_baseUrl + "/" + api, headers: headers);
  }

  httpGetById(String api, String categoryId) async {
    return await http.get(_baseUrl + "/" + api + "/" + categoryId,
        headers: headers);
  }

  /// Local database - sqlite
  Repository() {
    _connection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _connection.initDatabase();
    return _database;
  }

  getAllLocal(table) async {
    var conn = await database;
    return await conn.query(table);
  }

  saveLocal(table, data) async {
    var conn = await database;
    return await conn.insert(table, data);
  }

  updateLocal(table, columnName, data) async {
    var conn = await database;
    return await conn.update(table, data,
        where: '$columnName =?', whereArgs: [data['productId']]);
  }

  getLocalByCondition(table, columnName, conditionalValue) async {
    var conn = await database;
    return await conn.rawQuery(
        'SELECT * FROM $table WHERE $columnName=?', ['$conditionalValue']);
  }

  httpPost(String api, data) async {
    return await http.post(_baseUrl + "/" + api, body: data);
  }

  deleteLocalById(table, id) async {
    var conn = await database;
    return await conn.rawDelete("DELETE FROM $table WHERE id = $id");
  }
}
