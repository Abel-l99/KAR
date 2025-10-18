class AnneeCourante {
  final int? id;
  final DateTime anneeDebut;
  final DateTime anneeFin;
  final String ecole;
  final String classe;
  final String filiere;
  final String nbreDevoirs;
  final String valDevoirs;
  final String valExam;

  AnneeCourante({
    this.id,
    required this.anneeDebut,
    required this.anneeFin,
    required this.ecole,
    required this.classe,
    required this.filiere,
    required this.nbreDevoirs,
    required this.valDevoirs,
    required this.valExam,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'anneeDebut': anneeDebut.toIso8601String(),
      'anneeFin': anneeFin.toIso8601String(),
      'ecole': ecole,
      'classe': classe,
      'filiere': filiere,
      'nbreDevoirs': nbreDevoirs,
      'valDevoirs': valDevoirs,
      'valExam': valExam,
    };
  }

  factory AnneeCourante.fromMap(Map<String, dynamic> map) {
    return AnneeCourante(
      id: map['id'],
      anneeDebut: DateTime.parse(map['debut']),
      anneeFin: DateTime.parse(map['fin']),
      ecole: map['ecole'],
      classe: map['classe'],
      filiere: map['filiere'],
      nbreDevoirs: map['nbreDevoirs'],
      valDevoirs: map['valDevoirs'],
      valExam: map['valExam'],
    );
  }
}
