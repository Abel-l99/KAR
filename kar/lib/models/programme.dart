class Programme {
  final int? id;
  final DateTime jour;
  final int statut;

  Programme({
    this.id,
    required this.jour,
    required this.statut,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jour': jour.toIso8601String(),
      'statut': statut,
    };
  }

  factory Programme.fromMap(Map<String, dynamic> map) {
    return Programme(
      id: map['id'],
      jour: DateTime.parse(map['jour']),
      statut: map['statut'],
    );
  }
}
