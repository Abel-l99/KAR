import 'package:flutter/material.dart';
import 'package:kar/screens/account_screen.dart';
import 'package:kar/screens/home_screen.dart';
import 'package:kar/services/auth_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await testAuth();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AccountScreen(),
    );
  }
}

Future <void> testAuth() async {
  // Enregistrer un utilisateur
  await AuthService.registerUser(
    username: "john",
    password: "123456",
    nom: "Doe",
    prenoms: "John",
    sexe: "M",
    age: 21,
    ecole: "Université X",
  );

  print("✅ Compte créé !");

  // Essayer de se connecter
  final user = await AuthService.loginUser(
    username: "john",
    password: "123456",
  );

  if (user != null) {
    print("🎉 Connexion réussie : ${user.username}");
  } else {
    print("❌ Identifiants incorrects");
  }
}
