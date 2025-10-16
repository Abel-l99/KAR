import 'package:flutter/material.dart';
import 'package:kar/screens/account_screen.dart';
import 'package:kar/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
              DrawerHeader(child: Text("Menu")),
              ListTile(title: Text("Accueil")),
              ListTile(title: Text("Vos informations")),
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
            // Ajoutez les cartes ici
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: screenWidth * 0.45,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 10,
                      child: ListTile(
                        title: Text('Matières à réviser'),
                        subtitle: Text("Ajoutez et gérez vos matières."),
                        onTap: () {
                          print("Carte 1 cliquée !");
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.45,
                    height: MediaQuery.of(context).size.height * 0.2,
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
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 10,
                      child: ListTile(
                        title: Text('Notes'),
                        subtitle: Text("Enregistrez vos notes et performances."),
                        onTap: () {
                          print("Carte 3 cliquée !");
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.2,
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
                builder: (context) => const AccountScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}