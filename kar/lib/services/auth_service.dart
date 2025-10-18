import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:kar/data/database_helper.dart';
import 'package:kar/models/utilisateur.dart';
import 'package:kar/screens/create_account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AuthService {
  static String hashPassword(String password){
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Création de compte
  static Future<int> registerUser({
    required String password,
    String? nom,
    String? prenoms,
    String? sexe,
    DateTime? dateNaissance,
  })async{
    final dbHelper = DatabaseHelper.instance;

    final hashedPassword = hashPassword(password);

    final user = Utilisateur(
        password: hashedPassword,
        nom: nom ?? '',
        prenoms: prenoms ?? '',
        sexe: sexe ?? '',
        dateNaissance: dateNaissance ?? DateTime.now(),
    );

    return await dbHelper.ajouterUtilisateur(user);

  }



  // Connexion
  static Future<Utilisateur?> login({
    required String password,
  })async{
    final dbHelper = DatabaseHelper.instance;
    final db = await dbHelper.database;

    final hashedPassword = hashPassword(password);

    final result = await db.query(
        'utilisateur',
      where: 'password = ?',
      whereArgs: [hashedPassword]
    );

    if (result.isNotEmpty){
      final utilisateur = Utilisateur.fromMap(result.first);
      String dateNaissanceString = utilisateur.dateNaissance.toIso8601String();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('nom', utilisateur.nom);
      await prefs.setString('prenoms', utilisateur.prenoms);
      await prefs.setString('sexe', utilisateur.sexe);
      await prefs.setString('dateNaissance', dateNaissanceString);

      return utilisateur;
    }else{
      return null;
    }
  }


  //Déconnexion
  static Future<void> logout() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

  }

}