class Utilisateur {
  final String password;
  final String nom;
  final String prenoms;

  Utilisateur({
    required this.password,
    required this.nom,
    required this.prenoms,
  });

  Map<String, dynamic> toMap(){
    return {
      'password':password,
      'nom':nom,
      'prenoms':prenoms,
    };
  }

  factory Utilisateur.fromMap(Map<String, dynamic> map){
    return Utilisateur(
        password: map['password'],
        nom: map['nom'],
        prenoms: map['prenoms'],
    );
  }

}