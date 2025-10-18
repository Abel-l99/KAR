import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<CreateAccount> {

  String? selectedDate;
  String? selectedSexe;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Créez un compte"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nom",
                ),
              ),

              SizedBox(height: screenHeight*0.01),
          
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Prénoms",
                ),
              ),

              SizedBox(height: screenHeight*0.01),

              GestureDetector(
                onTap: () => selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: selectedDate ?? "Date de naissance",
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight*0.01),


              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedSexe,
                hint: const Text("Sexe"),
                items: const [
                  DropdownMenuItem(
                    value: 'masculin',
                    child: Text('Masculin'),
                  ),
                  DropdownMenuItem(
                    value: 'féminin',
                    child: Text('Féminin'),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSexe = newValue;
                  });
                },
                validator: (value) =>
                value == null ? "Veuillez sélectionner un sexe" : null,
              ),

              SizedBox(height: screenHeight*0.01),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Mot de passe",
                ),
              ),

              SizedBox(height: screenHeight*0.01),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Confirmation de mot de passe",
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
