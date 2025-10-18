class Semestre {
  final int? id;
  final int libelle;

  Semestre({
    this.id,
    required this.libelle,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'libelle': libelle,
    };
  }

  factory Semestre.fromMap(Map<String, dynamic> map) {
    return Semestre(
      id: map['id'],
      libelle: map['libelle'],
    );
  }
}