import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SaveMatiere extends StatefulWidget {
  const SaveMatiere({super.key});

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

      body: Column(
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


              for (int i = 1; i <= 3; i++)
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


              for (int i = 1; i <= 3; i++)
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

    ));
  }
}
