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
          CREATE TABLE anneeCourante (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              anneeDebut TEXT NOT NULL,
              anneeFin TEXT NOT NULL,
              ecole VARCHAR(100) NOT NULL,
              classe VARCHAR(30) NOT NULL,
              filiere VARCHAR(50) NOT NULL,
              nbreDevoirs INTEGER NOT NULL,
              valDevoirs INTEGER NOT NULL,
              valExam INTEGER NOT NULL
          );
        ''');

        await db.execute('''
          CREATE TABLE utilisateur (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom VARCHAR(100),
            prenoms VARCHAR(100),
            password TEXT NOT NULL,
            dateNaissance TEXT,
            sexe VARCHAR(10)
          );
        ''');


        await db.execute('''
          CREATE TABLE semestre (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            libSemestre INTEGER NOT NULL
          );
        ''');

        await db.execute('''
          CREATE TABLE matiere (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            libMatiere VARCHAR(100) NOT NULL,
            coef INTEGER NOT NULL,
            anneeId INTEGER NOT NULL,
            semestreId INTEGER NOT NULL,
            FOREIGN KEY (anneeId) REFERENCES anneeCourante(id) ON DELETE CASCADE,
            FOREIGN KEY (semestreId) REFERENCES semestre(id) ON DELETE CASCADE
          );
        ''');

        await db.execute('''
          CREATE TABLE composition (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type VARCHAR(10) NOT NULL,
            dateCompo TEXT NOT NULL,
            matiereId INTEGER NOT NULL,
            FOREIGN KEY (matiereId) REFERENCES matiere(id) ON DELETE CASCADE
          );  
        ''');

        await db.execute('''
          CREATE TABLE programme (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            jour TEXT NOT NULL,
            statut TEXT CHECK(statut IN ('respecté', 'non respecté'))
          );
        ''');

        await db.execute('''
          CREATE TABLE matiere_programme (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            matiereId INTEGER NOT NULL,
            programmeId INTEGER NOT NULL,
            statut TEXT CHECK(statut IN ('validé', 'non validé')),
            FOREIGN KEY (matiereId) REFERENCES matiere(id) ON DELETE CASCADE,
            FOREIGN KEY (programmeId) REFERENCES programme(id) ON DELETE CASCADE,
            UNIQUE (matiereId, programmeId)
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

  Future<List<Utilisateur>> getAllUtilisateurs() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('utilisateur');

    return result.map((e) => Utilisateur.fromMap(e)).toList();
  }

}