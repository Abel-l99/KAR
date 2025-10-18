import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kar/screens/create_account.dart';
import 'package:kar/screens/home_screen.dart';
import 'package:kar/services/auth_service.dart';
import 'package:sqflite/sqflite.dart';

import 'data/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      //home: HomeScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
      home: CreateAccount(),
    );
  }
}