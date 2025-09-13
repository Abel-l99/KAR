import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'kar_database.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE annee(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            debut INTEGER,
            fin INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE utilisateur(
            username VARCHAR(10) PRIMARY KEY,
            nom VARCHAR(15),
            prenoms VARCHAR(50),
            password TEXT,
            sexe VARCHAR(10),
            age INTEGER,
            ecole VARCHAR(50),
            anneId INTEGER,
            FOREIGN KEY (anneeId) REFERENCES annee (id) ON DELETE CASCADE
          )
        ''');


        await db.execute('''
          CREATE TABLE unitensg(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            libelle VARCHAR(25)
            nbreMatiere INTEGER,
            semestre INTEGER,
            credit INTEGER,
            anneId INTEGER,
            FOREIGN KEY (anneeId) REFERENCES annee (id) ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE TABLE matiere(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            libelle VARCHAR(100),
            coef INTEGER,
            unitensgId INTEGER,
            FOREIGN KEY (unitensgId) REFERENCES unitensg (id) ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE TABLE composition(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT,
            date DATETIME,
            note INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE programme(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            jour TEXT,
            anneeId INTEGER,
            matieres TEXT,
            FOREIGN KEY (anneeId) REFERENCES annee (id) ON DELETE CASCADE
          )
        ''');

      },
    );
  }
}