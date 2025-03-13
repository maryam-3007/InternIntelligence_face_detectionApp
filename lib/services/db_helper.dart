import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'faces.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE faces (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            embedding TEXT,  -- Store as JSON string
            imagePath TEXT
          )
        ''');
      },
    );
  }

  static Future<int> saveFace(String name, List<double> embedding, String imagePath) async {
    final db = await database;
    return await db.insert(
      'faces',
      {
        'name': name,
        'embedding': jsonEncode(embedding), 
        'imagePath': imagePath,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getFaces() async {
    final db = await database;
    return await db.query('faces');
  }

  static Future<List<Map<String, dynamic>>> getParsedFaces() async {
    final db = await database;
    final List<Map<String, dynamic>> faces = await db.query('faces');
    
    return faces.map((face) {
      return {
        'id': face['id'],
        'name': face['name'],
        'embedding': List<double>.from(jsonDecode(face['embedding'])),  
        'imagePath': face['imagePath'],
      };
    }).toList();
  }

 static Future<int> deleteFace(int id) async {
  final db = await database;
  return await db.delete('faces', where: 'id = ?', whereArgs: [id]);
}
}