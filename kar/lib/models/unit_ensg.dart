class UnitEnsg {
  final int? id;
  final String libelle;
  final int nbreMatiere;
  final int semestre;
  final int credit;

  UnitEnsg({
    this.id,
    required this.libelle,
    required this.nbreMatiere,
    required this.semestre,
    required this.credit,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'libelle': libelle,
      'nbreMatiere': nbreMatiere,
      'semestre': semestre,
      'credit': credit,
    };
  }

  factory UnitEnsg.fromMap(Map<String, dynamic> map) {
    return UnitEnsg(
      id: map['id'],
      libelle: map['libelle'],
      nbreMatiere: map['nbreMatiere'],
      semestre: map['semestre'],
      credit: map['credit'],
    );
  }
}
