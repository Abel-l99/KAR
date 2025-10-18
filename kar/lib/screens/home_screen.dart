import 'package:flutter/material.dart';
import 'package:kar/screens/create_account.dart';
import 'package:kar/screens/annee_courante.dart';
import 'package:kar/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme; // Ajouté pour le changement de thème
  final bool isDarkMode; // Pour savoir quel thème est actif

  const HomeScreen({required this.toggleTheme, required this.isDarkMode, super.key});



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? nom;
  String? prenoms;
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
                  Text("Date de naissance : dateNaissance"),
                  Text("Sexe : sexe"),
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
              ListTile(
                title: Text("Déconnexion"),
                onTap: () {},
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
                          print("Carte 2 cliquée !");
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
                          print("Carte 3 cliquée !");
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // AuthService.logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateAccount(),
              ),
            );
          },
        ),
      ),
    );
  }
}