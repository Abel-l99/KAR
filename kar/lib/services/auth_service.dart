import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:kar/data/database_helper.dart';
import 'package:kar/models/utilisateur.dart';
import 'package:kar/screens/account_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AuthService {
  static String hashPassword(String password){
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<int> registerUser({
    required String username,
    required String password,
    String? nom,
    String? prenoms,
    String? sexe,
    int? age,
    String? ecole
  })async{
    final dbHelper = DatabaseHelper.instance;

    final hashedPassword = hashPassword(password);

    final user = Utilisateur(
        username: username,
        password: hashedPassword,
        nom: nom ?? '',
        prenoms: prenoms ?? '',
        sexe: sexe ?? '',
        age: age ?? 0,
        ecole: ecole ?? '',
    );

    return await dbHelper.ajouterUtilisateur(user);

  }




  static Future<Utilisateur?> login({
    required String username,
    required String password,
  })async{
    final dbHelper = DatabaseHelper.instance;
    final db = await dbHelper.database;

    final hashedPassword = hashPassword(password);

    final result = await db.query(
        'utilisateur',
      where: 'username = ? AND password = ?',
      whereArgs: [username, hashedPassword]
    );

    if (result.isNotEmpty){
      final utilisateur = Utilisateur.fromMap(result.first);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', utilisateur.username);
      await prefs.setString('nom', utilisateur.nom);
      await prefs.setString('prenoms', utilisateur.prenoms);

      return utilisateur;
    }else{
      return null;
    }
  }




  static Future<void> logout() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

  }

}