import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kar/screens/save_matiere.dart';

class AnneeCourante extends StatefulWidget {
  const AnneeCourante({super.key});

  @override
  State<AnneeCourante> createState() => _AnneeCouranteState();
}

class _AnneeCouranteState extends State<AnneeCourante> {
  int? anneeSelect;
  int anneeCourante = DateTime.now().year;

  final TextEditingController anneeDebutController = TextEditingController();
  final TextEditingController anneeFinController = TextEditingController();
  final TextEditingController ecoleController = TextEditingController();
  final TextEditingController classeController = TextEditingController();
  final TextEditingController filiereController = TextEditingController();
  final TextEditingController valDevoirController = TextEditingController();
  final TextEditingController valExamController = TextEditingController();
  final TextEditingController semestre1Controller = TextEditingController();
  final TextEditingController semestre2Controller = TextEditingController();

  int? anneeDebut;
  int? anneeFin;
  String? ecole;
  String? classe;
  String? valDevoirs;
  String? valExam;
  int? semestre1;
  int? semestre2;


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Année courante"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Année académique:",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Début",
                    ),
                    value: anneeSelect,
                    items: List.generate(anneeCourante-2020+2, (index){
                      int annee = anneeCourante-index;
                      return DropdownMenuItem<int>(
                        value: annee,
                          child: Text(annee.toString())
                      );
                    }),
                    onChanged: (int? value) {
                      setState(() {
                        anneeSelect = value;
                        anneeDebutController.text = anneeSelect?.toString() ?? '';
                      });
                    },
                  ),
                ),

                Text(" - "),

                Flexible(
                  child: DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Fin",
                    ),
                    value: anneeSelect,
                    items: List.generate(anneeCourante-2020+2, (index){
                      int annee = anneeCourante+1-index;
                      return DropdownMenuItem<int>(
                          value: annee,
                          child: Text(annee.toString())
                      );
                    }),
                    onChanged: (int? value) {
                      anneeSelect = value;
                      anneeFinController.text = anneeSelect?.toString() ?? '';
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Ecole:",
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: ecoleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Entrez votre nom",
              ),
            ),

            Text(
              "Classe:",
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: classeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Entrez votre nom",
              ),
            ),

            Text(
              "Filière:",
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: filiereController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Entrez votre nom",
              ),
            ),

            Text(
              "Compositions:",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: valDevoirController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Valeur du devoir",
                    ),
                  ),
                ),

                SizedBox(width: screenWidth*0.03),

                Flexible(
                  child: TextField(
                    controller: valExamController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Valeur des examens",
                    ),
                  ),
                ),
              ],
            ),

            Text(
              "Nombre de matières:",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: semestre1Controller,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "1er semestre",
                    ),
                  ),
                ),

                SizedBox(width: screenWidth*0.03),

                Flexible(
                  child: TextField(
                    controller: semestre2Controller,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "2ième semestre",
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight*0.01),

            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SaveMatiere(
                        anneeDebut: anneeDebutController,
                        anneeFin: anneeFinController,
                        ecole: ecoleController,
                        classe: classeController,
                        filiere: filiereController,
                        valDevoirs: valDevoirController,
                        valExam: valExamController,
                        semestre1: semestre1Controller,
                        semestre2: semestre2Controller
                      ))
                  );
                },
                child: Text("Valider")
            )

          ],
        ),
      ),
    ));
  }
}
