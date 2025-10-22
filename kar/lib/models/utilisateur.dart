class Utilisateur {
  final String password;
  final String nom;
  final String prenoms;
  final String sexe;
  final DateTime dateNaissance;

  Utilisateur({
    required this.password,
    required this.nom,
    required this.prenoms,
    required this.sexe,
    required this.dateNaissance,
  });

  Map<String, dynamic> toMap(){
    return {
      'password':password,
      'nom':nom,
      'prenoms':prenoms,
      'sexe':sexe,
      'dateNaissance' :dateNaissance.toIso8601String()
    };
  }

  factory Utilisateur.fromMap(Map<String, dynamic> map){
    return Utilisateur(
        password: map['password'],
        nom: map['nom'],
        prenoms: map['prenoms'],
        sexe: map['sexe'],
        dateNaissance: DateTime.parse(map['dateNaissance']),
    );
  }

}