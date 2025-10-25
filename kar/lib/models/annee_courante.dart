class AnneeCourante {
  final int? id;
  final int anneeDebut;
  final int anneeFin;
  final String ecole;
  final String classe;
  final String filiere;
  final String valDevoirs;
  final String valExam;
  final String statutAnnee;

  AnneeCourante({
    this.id,
    required this.anneeDebut,
    required this.anneeFin,
    required this.ecole,
    required this.classe,
    required this.filiere,
    required this.valDevoirs,
    required this.valExam,
    required this.statutAnnee
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'anneeDebut': anneeDebut,
      'anneeFin': anneeFin,
      'ecole': ecole,
      'classe': classe,
      'filiere': filiere,
      'valDevoirs': valDevoirs,
      'valExam': valExam,
      'statutAnnee':statutAnnee,
    };
  }

  factory AnneeCourante.fromMap(Map<String, dynamic> map) {
    return AnneeCourante(
      id: map['id'],
      anneeDebut: map['debut'],
      anneeFin: map['fin'],
      ecole: map['ecole'],
      classe: map['classe'],
      filiere: map['filiere'],
      valDevoirs: map['valDevoirs'],
      valExam: map['valExam'],
      statutAnnee: map['statutAnnee'],
    );
  }
}
