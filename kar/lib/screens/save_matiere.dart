import 'package:flutter/material.dart';
import 'package:kar/models/annee_courante.dart';
import 'package:kar/models/matiere.dart';

import '../data/database_helper.dart';

class SaveMatiere extends StatefulWidget {
  final TextEditingController anneeDebut;
  final TextEditingController anneeFin;
  final TextEditingController ecole;
  final TextEditingController classe;
  final TextEditingController filiere;
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
    required this.filiere,
    required this.valDevoirs,
    required this.valExam,
    required this.semestre1,
    required this.semestre2,
  }) : super(key: key);

  @override
  State<SaveMatiere> createState() => _SaveMatiereState();
}

class _SaveMatiereState extends State<SaveMatiere> {
  final List<TextEditingController> matieresSem1 = [];
  final List<TextEditingController> matieresSem2 = [];
  final List<int?> coefsSem1 = [];
  final List<int?> creditsSem1 = [];
  final List<int?> coefsSem2 = [];
  final List<int?> creditsSem2 = [];

  @override
  void initState() {
    super.initState();

    int countSem1 = int.tryParse(widget.semestre1.text) ?? 0;
    int countSem2 = int.tryParse(widget.semestre2.text) ?? 0;

    for (int i = 0; i < countSem1; i++) {
      matieresSem1.add(TextEditingController());
      coefsSem1.add(null);
      creditsSem1.add(null);
    }
    for (int i = 0; i < countSem2; i++) {
      matieresSem2.add(TextEditingController());
      coefsSem2.add(null);
      creditsSem2.add(null);
    }
  }

  @override
  void dispose() {
    for (var c in matieresSem1) c.dispose();
    for (var c in matieresSem2) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Matières"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTable("1er semestre", matieresSem1, coefsSem1, creditsSem1),
              _buildTable("2e semestre", matieresSem2, coefsSem2, creditsSem2),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: const Text("Enregistrer les matières"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTable(
      String title,
      List<TextEditingController> matieres,
      List<int?> coefs,
      List<int?> credits,
      ) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(0.7),
      },
      children: [
        TableRow(children: [
          Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
          const Center(child: Text("Coef")),
          const Center(child: Text("Crédit")),
        ]),
        for (int i = 0; i < matieres.length; i++)
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: matieres[i],
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              value: coefs[i],
              items: List.generate(15, (index) {
                int value = index + 1;
                return DropdownMenuItem(value: value, child: Text(value.toString()));
              }),
              onChanged: (v) => setState(() => coefs[i] = v),
            ),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              value: credits[i],
              items: List.generate(15, (index) {
                int value = index + 1;
                return DropdownMenuItem(value: value, child: Text(value.toString()));
              }),
              onChanged: (v) => setState(() => credits[i] = v),
            ),
          ]),
      ],
    );
  }

  Future<void> _saveData() async {
    final annee = AnneeCourante(
      anneeDebut: int.tryParse(widget.anneeDebut.text) ?? 0,
      anneeFin: int.tryParse(widget.anneeFin.text) ?? 0,
      ecole: widget.ecole.text,
      classe: widget.classe.text,
      filiere: widget.filiere.text,
      valDevoirs: widget.valDevoirs.text,
      valExam: widget.valExam.text,
      statutAnnee: "en cours",
    );

    List<Matiere> toutesMatieres = [];

    for (int i = 0; i < matieresSem1.length; i++) {
      toutesMatieres.add(Matiere(
        libMatiere: matieresSem1[i].text,
        coef: coefsSem1[i] ?? 0,
        credit: creditsSem1[i] ?? 0,
        semestre: 1,
        anneeId: 0,
      ));
    }

    for (int i = 0; i < matieresSem2.length; i++) {
      toutesMatieres.add(Matiere(
        libMatiere: matieresSem2[i].text,
        coef: coefsSem2[i] ?? 0,
        credit: creditsSem2[i] ?? 0,
        semestre: 2,
        anneeId: 0,
      ));
    }

    // Pour test :
    await DatabaseHelper.instance.ajouterAnneeEtMatieres(annee, toutesMatieres);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Matières enregistrées avec succès ✅")),
    );
  }
}
