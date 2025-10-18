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
                    onChanged: (int? value) {  },
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
                    onChanged: (int? value) {  },
                  ),
                ),
              ],
            ),

            Text(
              "Ecole:",
              style: TextStyle(fontSize: 16),
            ),
            TextField(
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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
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
                      MaterialPageRoute(builder: (context) => SaveMatiere())
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
