import 'package:flutter/material.dart';
import 'package:kar/screens/plannifier_devoir.dart';
import '../data/database_helper.dart';
import '../models/matiere.dart';

class Compo extends StatefulWidget {
  const Compo({super.key});

  @override
  State<Compo> createState() => _CompoState();
}

class _CompoState extends State<Compo> {
  Future<List<Matiere>>? _matieres;

  @override
  void initState(){
    super.initState();
    afficherMatieres();
  }

  void afficherMatieres() async {
    try {
      final matieres = await DatabaseHelper.instance.recupererMatieres();

      setState(() {
        _matieres = Future.value(matieres);
      });

    } catch (e) {
      print("❌ Erreur lors du chargement: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mes matières"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Matiere>>(
                future: _matieres,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Erreur: ${snapshot.error}'));
                  }

                  final matieres = snapshot.data ?? [];

                  if (matieres.isEmpty) {
                    return const Center(
                      child: Text('Aucune matière disponible'),
                    );
                  }

                  return ListView.builder(
                    itemCount: matieres.length,
                    itemBuilder: (context, index) {
                      final matiere = matieres[index];
                      return ListTile(
                        title: Text(matiere.libMatiere),
                        subtitle: Text('Coef: ${matiere.coef} | Crédits: ${matiere.credit}'),
                        trailing: Text('S${matiere.semestre}'),
                      );
                    },
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>PlannifierDevoir())
                      );
                    },
                    child: Text("Devoirs")
                ),

                OutlinedButton(
                    onPressed: (){

                    },
                    child: Text("Examen")
                )
              ],
            )
          ],
        ),

      ),
    );
  }
}