import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/utilisateur.dart';

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
          CREATE TABLE annee (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              debut DATE NOT NULL,
              fin DATE NOT NULL
          );
        ''');

        await db.execute('''
          CREATE TABLE utilisateur (
            username VARCHAR(50) PRIMARY KEY,
            nom VARCHAR(100),
            prenoms VARCHAR(100),
            password TEXT NOT NULL,
            sexe VARCHAR(10),
            age INTEGER,
            ecole VARCHAR(100),
            anneeId INTEGER,
            FOREIGN KEY (anneeId) REFERENCES annee(id) ON DELETE CASCADE
          );
        ''');


        await db.execute('''
          CREATE TABLE unitensg (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            libelle VARCHAR(100) NOT NULL,
            nbreMatiere INTEGER NOT NULL,
            semestre INTEGER NOT NULL,
            credit INTEGER NOT NULL,
            anneeId INTEGER NOT NULL,
            FOREIGN KEY (anneeId) REFERENCES annee(id) ON DELETE CASCADE
          );
        ''');

        await db.execute('''
          CREATE TABLE matiere (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            libelle VARCHAR(100) NOT NULL,
            coef INTEGER NOT NULL,
            unitensgId INTEGER NOT NULL,
            FOREIGN KEY (unitensgId) REFERENCES unitensg(id) ON DELETE CASCADE
          );
        ''');

        await db.execute('''
          CREATE TABLE composition (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT NOT NULL,
            date DATE NOT NULL,
            matiereId INTEGER NOT NULL,
            FOREIGN KEY (matiereId) REFERENCES matiere(id) ON DELETE CASCADE
          );  
        ''');

        await db.execute('''
          CREATE TABLE composition_matiere (
            compositionId INTEGER NOT NULL,
            matiereId INTEGER NOT NULL,
            note INTEGER,
            PRIMARY KEY (compositionId, matiereId),
            FOREIGN KEY (compositionId) REFERENCES composition(id) ON DELETE CASCADE,
            FOREIGN KEY (matiereId) REFERENCES matiere(id) ON DELETE CASCADE
          );
        ''');

        await db.execute('''
          CREATE TABLE statutMatiere (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            libelle TEXT CHECK(libelle IN ('Validé','En attente','Non validé')) NOT NULL
          );
        ''');

        await db.execute('''
          CREATE TABLE statutProgr (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            libelle TEXT CHECK(libelle IN ('A venir','Terminé','Pas terminé')) NOT NULL
          );
        ''');

        await db.execute('''
          CREATE TABLE statutMatProgr (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            libelle TEXT CHECK(libelle IN ('Prévu','Réalisé','Non réalisé')) NOT NULL
          );
        ''');

        await db.execute('''
          CREATE TABLE programme (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            jour DATE NOT NULL,
            statutId INTEGER NOT NULL,
            FOREIGN KEY (statutId) REFERENCES statutProgr(id) ON DELETE CASCADE
          );
        ''');

        await db.execute('''
          CREATE TABLE programme_matiere (
            programmeId INTEGER NOT NULL,
            matiereId INTEGER NOT NULL,
            statutId INTEGER NOT NULL,
            PRIMARY KEY (programmeId, matiereId),
            FOREIGN KEY (programmeId) REFERENCES programme(id) ON DELETE CASCADE,
            FOREIGN KEY (matiereId) REFERENCES matiere(id) ON DELETE CASCADE,
            FOREIGN KEY (statutId) REFERENCES statutMatProgr(id) ON DELETE CASCADE
          );
        ''');

      },
    );
  }

  Future<int> ajouterUtilisateur(Utilisateur user) async{
    final Database db = await database;
    
    return await db.insert(
        'utilisateur',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

}