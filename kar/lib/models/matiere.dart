class Matiere {
  final int? id;
  final String libMatiere;
  final int coef;
  final int credit;
  final int semestre;
  int anneeId;

  Matiere({
    this.id,
    required this.libMatiere,
    required this.coef,
    required this.credit,
    required this.semestre,
    required this.anneeId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'libMatiere': libMatiere,
      'coef': coef,
      'credit': credit,
      'semestre': semestre,
      'anneeId': anneeId,
    };
  }

  factory Matiere.fromMap(Map<String, dynamic> map) {
    return Matiere(
      id: map['id'],
      libMatiere: map['libMatiere'],
      coef: map['coef'],
      credit: map['credit'],
      semestre: map['semestre'],
      anneeId: map['anneeId'],
    );
  }
}