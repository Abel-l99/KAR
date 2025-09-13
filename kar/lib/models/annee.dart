class Annee {
  final int? id;
  final DateTime debut;
  final DateTime fin;

  Annee({
    this.id,
    required this.debut,
    required this.fin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'debut': debut.toIso8601String(),
      'fin': fin.toIso8601String(),
    };
  }

  factory Annee.fromMap(Map<String, dynamic> map) {
    return Annee(
      id: map['id'],
      debut: DateTime.parse(map['debut']),
      fin: DateTime.parse(map['fin']),
    );
  }
}
