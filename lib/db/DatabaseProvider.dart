import 'dart:io';
import 'package:flutter/services.dart';
import 'package:logo_quiz/models/Logo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:logo_quiz/models/Score.dart';
import 'package:logo_quiz/models/Categories.dart';
import 'package:logo_quiz/models/Setting.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider dbProvider = DatabaseProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "logo.db");

    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "logo.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    var databaseData = await openDatabase(path, readOnly: false);

    return databaseData;
  }

  Future<List<Logo>> getCategories() async {
    Database database = await this.database;
    var result = await database.query(
      'logotable',
      columns: ['categories', 'cat_id'],
      distinct: true,
    );

    List<Logo> list =
        result.isNotEmpty ? result.map((e) => Logo.fromMap(e)).toList() : [];
    return list;
  }

  Future<Logo> getImage(int id) async {
    Database database = await this.database;
    // var result =
    //     await database.query('logotable', where: 'id = ?', whereArgs: [id]);
    var result =
        await database.rawQuery('SELECT * FROM logotable WHERE id = $id');
    return result.isNotEmpty ? Logo.fromMap(result.first) : null;
  }

  Future<List<Logo>> getLogoGridPerTheme(int numberTheme) async {
    Database database = await this.database;
    // var result = await database.query('logotable',
    //     columns: ['categories', 'cat_id', 'img_name', 'ans'],
    //     where: 'cat_id = ?',
    //     whereArgs: [numberTheme]);

    var result = await database
        .rawQuery('SELECT * FROM logotable WHERE cat_id = $numberTheme');

    List<Logo> list =
        result.isNotEmpty ? result.map((e) => Logo.fromMap(e)).toList() : [];
    return list;
  }

  Future<List<Logo>> getLogoAll() async {
    Database database = await this.database;

    var result = await database.rawQuery('SELECT * FROM logotable WHERE');

    List<Logo> list =
        result.isNotEmpty ? result.map((e) => Logo.fromMap(e)).toList() : [];
    return list;
  }

  Future<List<Logo>> getLogoGridPerThemeWithFilter(int numberTheme) async {
    Database database = await this.database;
    // var result = await database.query('logotable',
    //     columns: ['categories', 'cat_id', 'img_name', 'ans'],
    //     where: 'cat_id = ?',
    //     whereArgs: [numberTheme]);

    var result = await database.rawQuery(
        'SELECT * FROM logotable WHERE cat_id = $numberTheme AND isWin = 0');

    List<Logo> list =
        result.isNotEmpty ? result.map((e) => Logo.fromMap(e)).toList() : [];
    return list;
  }

  Future<int> fetchSound() async {
    Database database = await this.database;

    var query = await database.rawQuery('SELECT sound from score');
    int count = Sqflite.firstIntValue(query);
    return count;
  }

  Future<int> fetchCoin() async {
    Database database = await this.database;

    var query = await database.rawQuery('SELECT score_coin from score');
    int count = Sqflite.firstIntValue(query);
    return count;
  }

  Future<int> updateScore(Score score) async {
    Database database = await this.database;

    var result = database
        .update("score", score.toMap(), where: 'id = ?', whereArgs: [1]);

    return result;
  }

  Future<int> updateSetting(Setting setting) async {
    Database database = await this.database;

    var result = database
        .update("setting", setting.toMap(), where: 'id = ?', whereArgs: [1]);

    return result;
  }

  Future<int> updateLogoStatus(Logo logo, int id) async {
    Database database = await this.database;
    var result = database
        .update("logotable", logo.toMap(), where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future<int> updateWinningLogo(Categories category, int id) async {
    Database database = await this.database;
    var result = database
        .update("category", category.toMap(), where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future<List<Categories>> fetchCategory() async {
    Database database = await this.database;

    var result = await database.rawQuery('SELECT * FROM category');

    List<Categories> list = result.isNotEmpty
        ? result.map((e) => Categories.fromMap(e)).toList()
        : [];
    return list;
  }

  Future<Categories> getCategory(int id) async {
    Database database = await this.database;
    // var result =
    //     await database.query('logotable', where: 'id = ?', whereArgs: [id]);
    var result =
        await database.rawQuery('SELECT * FROM category WHERE id = $id');
    return result.isNotEmpty ? Categories.fromMap(result.first) : null;
  }

  Future<int> fetchCount() async {
    Database database = await this.database;

    var query = await database.rawQuery('SELECT SUM(count) FROM category');
    int count = Sqflite.firstIntValue(query);
    return count;
  }
}
