class Programme {
  final int? id;
  final DateTime jour;
  final int statut; // 0 = à venir, 1 = terminé, 2 = pas terminé
  final int matiereId;

  Programme({
    this.id,
    required this.jour,
    required this.statut,
    required this.matiereId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jour': jour.toIso8601String(),
      'statut': statut,
      'matiereId': matiereId,
    };
  }

  factory Programme.fromMap(Map<String, dynamic> map) {
    return Programme(
      id: map['id'],
      jour: DateTime.parse(map['jour']),
      statut: map['statut'],
      matiereId: map['matiereId'],
    );
  }
}
