import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';

/// Manages a generic database.
///
/// This class is the foundation for all other database managers.
class AppDatabase {
  /// An instance of this database.
  late Database _db;
  /// The name of this database.
  String name;
  /// A list of commands to be executed on database creation.
  List<String> commands;
  // A lock that synchronizes all database insertions.
  static Lock lock = Lock();
  /// A function that is called when the [version] changes.
  final OnDatabaseVersionChangeFn onUpgrade;
  /// The version of this database.
  final int version;

  AppDatabase({required this.name, required this.commands, required this.onUpgrade, this.version = 1});

  /// Returns an instance of this database.
  Future<Database> getDatabase() async {
    _db = await initializeDatabase();
    return _db;
  }

  /// Inserts [values] into the corresponding [table] in this database.
  insertInDatabase(String table, Map<String, dynamic> values,
      {required String nullColumnHack, required ConflictAlgorithm conflictAlgorithm}) async {
    lock.synchronized(() async {
      print("here1");
      final Database db = await getDatabase();
      print("here2");
      db.insert(table, values,
          nullColumnHack: nullColumnHack, conflictAlgorithm: conflictAlgorithm);
      print("here3");
    });
  }

  /// Initializes this database.
  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database
    // Get the directory path for both Android and iOS to store database
    final String directory = await getDatabasesPath();
    final String path = join(directory, this.name);

    // Open or create the database at the given path
    final appFeupDatabase = await openDatabase(path,
        version: version, onCreate: _createDatabase, onUpgrade: onUpgrade);
    print("Database initialized\n");
    return appFeupDatabase;
  }

  /// Executes the commands present in [commands].
  void _createDatabase(Database db, int newVersion) async {
    for (String command in commands) {
      await db.execute(command);
      print(command);
    }
    print("CreateDatabase\n");
  }

  /// Removes the database called [name].
  static removeDatabase(String name) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path + name;

    await deleteDatabase(path);
  }
}
