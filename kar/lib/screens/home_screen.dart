import 'package:flutter/material.dart';
import 'package:kar/screens/account_screen.dart';
import 'package:kar/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? nom;
  String? prenoms;

  @override
  void initState(){
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
      prenoms = prefs.getString('prenoms');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Text("Bienvenu sur la page d'acceuil $nom $prenoms"),
          ),

          floatingActionButton: FloatingActionButton(
              onPressed: () async{
                AuthService.logout();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountScreen()
                    )
                );
              }
          ),
        )
    );
  }
}
