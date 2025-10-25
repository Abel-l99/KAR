import 'package:flutter/material.dart';
import 'package:kar/screens/authentification.dart';
import 'package:kar/screens/compo.dart';
import 'package:kar/screens/create_account.dart';
import 'package:kar/screens/annee_courante.dart';
import 'package:kar/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../data/database_helper.dart';
import '../models/matiere.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme; 
  final bool isDarkMode;

  const HomeScreen({required this.toggleTheme, required this.isDarkMode, super.key});



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void plannifier(BuildContext context, DateTime jour, Matiere matiere) async{
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Type de composition"),

            content: SizedBox(
              width: double.maxFinite,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: (){
                        DatabaseHelper.instance.planifierDevoir(
                          matiere,
                          "devoir",
                          jour
                        ).then((_) {
                          Navigator.of(context).pop(); // Ferme la boîte
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("✅ Devoir planifié pour ${matiere.libMatiere}"),
                            ),
                          );
                        });
                      },
                      child: Text("Devoir")
                  ),

                  OutlinedButton(
                      onPressed: (){

                      },
                      child: Text("Devoir")
                  )
                ],
              ),
            ),
          );

        }
    );
  }

  void lesMatieres(BuildContext context, DateTime date) async {
    try {
      final matieres = await DatabaseHelper.instance.recupererMatieres();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.school, color: Colors.blue),
                SizedBox(width: 8),
                Text("Toutes mes matières"),
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              height: 300,
              child: matieres.isEmpty
                  ? const Center(child: Text("Aucune matière disponible"))
                  : ListView.builder(
                itemCount: matieres.length,
                itemBuilder: (context, index) {
                  final matiere = matieres[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      onTap: (){
                        plannifier(context, date, matiere);
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          matiere.coef.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      title: Text(
                        matiere.libMatiere,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Crédits: ${matiere.credit} • Semestre: ${matiere.semestre}',
                      ),
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Fermer"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("❌ Erreur: $e");
    }
  }

  String? nom;
  String? prenoms;
  String? sexe;
  String? dateNaissance;

  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
      prenoms = prefs.getString('prenoms');
      sexe = prefs.getString('sexe');
      dateNaissance = prefs.getString('dateNaissance');
    });
  }

  void infosUtilisateur(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Vos informations"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Nom : $nom"),
                  Text("Prénoms : $prenoms"),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Fermer")
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("KAR"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Text("$nom $prenoms"),
                    CircleAvatar(
                      radius: screenWidth * 0.12,
                      child: Text(
                          "${nom != null && nom!.isNotEmpty ? nom![0].toUpperCase() : ''}${prenoms != null && prenoms!.isNotEmpty ? prenoms![0].toUpperCase() : ''}",
                        style: TextStyle(
                          fontSize: screenWidth*0.08,
                        ),
                      ),
                      backgroundColor: Colors.cyanAccent,
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text("Profil"),
                onTap: () {
                  infosUtilisateur(context);
                },
              ),
              ListTile(
                title: Text("Année courante"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnneeCourante())
                  );
                },
              ),
              ListTile(
                title: Text(widget.isDarkMode ? "Thème clair" : "Thème sombre"),
                onTap: widget.toggleTheme,
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            TableCalendar(
              locale: 'fr_FR',
              focusedDay: focusedDay,
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  this.selectedDay = selectedDay;
                  this.focusedDay = focusedDay;
                });
              },
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: screenWidth * 0.48,
                    height: screenHeight * 0.20,
                    child: Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 10,
                      child: ListTile(
                        title: Text('Programme de révision'),
                        subtitle: Text("Ajoutez et gérez votre emploi du temps personnel."),
                        onTap: () {
                          print("Carte 1 cliquée !");
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.48,
                    height: screenHeight * 0.20,
                    child: Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 10,
                      child: ListTile(
                        title: Text('Devoirs et examens'),
                        subtitle: Text("Consultez vos échéances de devoirs et examens pour rester organisé."),
                        onTap: () {
                          lesMatieres(context, selectedDay);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: screenWidth * 0.48,
                    height: screenHeight * 0.20,
                    child: Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 10,
                      child: ListTile(
                        title: Text('Notes'),
                        subtitle: Text("Enregistrez vos notes et suivre vos performances."),
                        onTap: () {

                        },
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.48,
                    height: screenHeight * 0.20,
                    child: Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 10,
                      child: ListTile(
                        title: Text('Evénements'),
                        subtitle: Text("Découvrez les activités à venir."),
                        onTap: () {
                          print("Carte 4 cliquée !");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}