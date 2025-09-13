class Matiere {
  final int? id;
  final String libelle;
  final int coef;

  Matiere({
    this.id,
    required this.libelle,
    required this.coef,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'libelle': libelle,
      'coef': coef,
    };
  }

  factory Matiere.fromMap(Map<String, dynamic> map) {
    return Matiere(
      id: map['id'],
      libelle: map['libelle'],
      coef: map['coef'],
    );
  }
}