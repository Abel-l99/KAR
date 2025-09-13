class Utilisateur {
  final String username;
  final String password;
  final String nom;
  final String prenoms;
  final String sexe;
  final int age;
  final String ecole;

  Utilisateur({
    required this.username,
    required this.password,
    required this.nom,
    required this.prenoms,
    required this.sexe,
    required this.age,
    required this.ecole,
  });

  Map<String, dynamic> toMap(){
    return {
      'username':username,
      'password':password,
      'nom':nom,
      'prenoms':prenoms,
      'sexe':sexe,
      'age':age,
      'ecole':ecole,
    };
  }

  factory Utilisateur.fromMap(Map<String, dynamic> map){
    return Utilisateur(
        username: map['username'],
        password: map['password'],
        nom: map['nom'],
        prenoms: map['prenoms'],
        sexe: map['sexe'],
        age: map['age'],
        ecole: map['ecole']
    );
  }

}