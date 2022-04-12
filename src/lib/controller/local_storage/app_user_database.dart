import 'package:flutter/material.dart';
import 'package:food_feup/controller/local_storage/app_database.dart';
import 'package:food_feup/model/user.dart';
import 'package:sqflite_common/sqlite_api.dart';

class AppUserDatabase extends AppDatabase {
  AppUserDatabase() :
        super(name: 'data/userDatabase.db',commands: ['CREATE TABLE userdata(key TEXT, value TEXT)',
                                  'INSERT INTO userdata VALUES (123, "123")'], onUpgrade: updateDatabase) {
        print("after super\n");
  }

  Future<bool> checkUser(String username, String password) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('userdata');

    for(Map<String, dynamic> map in maps) {
      if(map['key'] == username) {
        if(map['value'] == password) {
          return true;
        }
        return false;
      }
    }

    return false;
  }

  Future<void> insertUser(User user) async {
    print('here5');
    insertInDatabase(
        'userdata', {'key': user.userNumber, 'value': user.passWord}, conflictAlgorithm: ConflictAlgorithm.replace, nullColumnHack: '');
  }

  static Future<void> updateDatabase(
      Database db, int oldVersion, int newVersion) async {
    final batch = db.batch();
    if (oldVersion == 1) {
      batch.execute('DROP TABLE IF EXISTS userdata');
      batch.execute('CREATE TABLE userdata(key TEXT, value TEXT)');
    }
    await batch.commit();
  }
}