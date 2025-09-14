import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey =GlobalKey<FormState>();

  final _usernameController =TextEditingController();
  final _nomController =TextEditingController();
  final _prenomsController =TextEditingController();
  final _sexeController =TextEditingController();
  final _ageController =TextEditingController();
  final _ecoleController =TextEditingController();
  final _passwordController =TextEditingController();
  final _confirmPasswordController =TextEditingController();

  bool _isLoading = false;
  bool _forLogin = true;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text(
              _forLogin ? "Se connecter" : "S'inscrire",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
              ),
            ),
            centerTitle: true,
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_2),
                      labelText: "Nom d'utilisateur",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.cyan)
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Champ obligatoire";
                      }
                      return null;
                    },
                  ),

                  if(!_forLogin) TextFormField(
                    controller: _nomController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_2),
                      labelText: "Nom",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.cyan)
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Champ obligatoire";
                      }
                      return null;
                    },
                  ),

                  if(!_forLogin) TextFormField(
                    controller: _prenomsController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_2),
                      labelText: "Prénoms",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.cyan)
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Champ obligatoire";
                      }
                      return null;
                    },
                  ),

                  if(!_forLogin) TextFormField(
                    controller: _sexeController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_2),
                      labelText: "sexe",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.cyan)
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Champ obligatoire";
                      }
                      return null;
                    },
                  ),

                  if(!_forLogin) TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_2),
                      labelText: "Age",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.cyan)
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Champ obligatoire";
                      }
                      return null;
                    },
                  ),

                  if(!_forLogin) TextFormField(
                    controller: _ecoleController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_2),
                      labelText: "Ecole",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.cyan)
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Champ obligatoire";
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_2),
                      labelText: "Mot de passe",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.cyan)
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Champ obligatoire";
                      }
                      return null;
                    },
                  ),

                  if(!_forLogin) TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_2),
                      labelText: "Confirmation de mot de passe",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.cyan)
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Champ obligatoire";
                      }
                      return null;
                    },
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Traiter la soumission du formulaire
                      }
                    },
                    child: Text(_forLogin ? "Se connecter" : "S'inscrire"),
                  ),

                  TextButton(
                    onPressed: () {
                      setState(() {
                        _forLogin = !_forLogin; // Change l'état
                      });
                    },
                    child: Text(_forLogin ? "Créer un compte" : "Déjà un compte ?"),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}
