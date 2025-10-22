import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SaveMatiere extends StatefulWidget {
  final TextEditingController anneeDebut;
  final TextEditingController anneeFin;
  final TextEditingController ecole;
  final TextEditingController classe;
  final TextEditingController valDevoirs;
  final TextEditingController valExam;
  final TextEditingController semestre1;
  final TextEditingController semestre2;

  const SaveMatiere({
    Key? key,
    required this.anneeDebut,
    required this.anneeFin,
    required this.ecole,
    required this.classe,
    required this.valDevoirs,
    required this.valExam,
    required this.semestre1,
    required this.semestre2,
  }) : super(key: key);

  @override
  State<SaveMatiere> createState() => _SaveMatiereState();
}

class _SaveMatiereState extends State<SaveMatiere> {
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Matières"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Table(
              border: TableBorder.all(),
              columnWidths: {
                0: FixedColumnWidth(screenWidth*0.8),
                1: FixedColumnWidth(screenWidth*0.2)
              },
              children: [
                TableRow(
                  children: [
                    Text("Matières"),
                    Text("Coefficients")
                  ],
                ),
        
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "1er semestre",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
        
        
                for (int i = 1; i <= (int.tryParse(widget.semestre1.text) ?? 0); i++)
                  TableRow(
                    children: [
                      TextField(),
        
                      DropdownButtonFormField<int>(
                        items: List.generate(15, (index){
                          int coef = index+1;
                          return DropdownMenuItem<int>(
                              value: coef,
                              child: Text(coef.toString())
                          );
                        }),
                        onChanged: (int? value) {  },
                      ),
                    ],
                  ),
        
        
        
        
        
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "2ième semestre",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
        
        
                for (int i = 1; i <= (int.tryParse(widget.semestre2.text) ?? 0); i++)
                  TableRow(
                    children: [
                      TextField(),
        
                      DropdownButtonFormField<int>(
                        items: List.generate(15, (index){
                          int coef = index+1;
                          return DropdownMenuItem<int>(
                              value: coef,
                              child: Text(coef.toString())
                          );
                        }),
                        onChanged: (int? value) {  },
                      ),
                    ],
                  ),
        
        
              ],
            ),
        
            ElevatedButton(
              onPressed: () {
                print("Bouton pressé !");
              },
              child: Text("Appuyer ici"),
            ),
          ],
        ),
      ),

    ));
  }
}
