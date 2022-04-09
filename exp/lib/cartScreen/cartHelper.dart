import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = "myCartDatabase111111555555.db";
  static final _dbversion = 1;
  static final _tableName = "cart1";

  //static final colid = '_id';
  //static final colname = 'name';

  // static final brand = 'brand';
  // static final category = 'category';
  // static final name = 'name';
  // static final images = 'images';
  // static final quantity = 'quantity';
  // static final price = 'price';
  // static final fadeprice = 'fadeprice';
  static final cartId = 'cartId';
  static final productId = 'productId';
  static final number = 'number';
  static final qty = 'qty';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        $cartId TEXT NOT NULL,
         $productId TEXT NOT NULL,
         $number INTEGER,
         $qty TEXT NOT NULL)
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    List c = [];
    try {
      c = await db.query(_tableName);
    } catch (e) {
      print(e.toString());
      c = [];
    }
    return c;
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String cid = row[cartId];
    return await db
        .update(_tableName, row, where: '$cartId=?', whereArgs: [cid]);
  }

  Future<int> delete(String cid) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$cartId=?', whereArgs: [cid]);
  }
}
