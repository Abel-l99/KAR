class Composition {
  final int? id;
  final String type;
  final DateTime date;
  final int matiereId;

  Composition({
    this.id,
    required this.type,
    required this.date,
    required this.matiereId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'dateCompo': date.toIso8601String(),
      'matiereId': matiereId,
    };
  }

  factory Composition.fromMap(Map<String, dynamic> map) {
    return Composition(
      id: map['id'],
      type: map['type'],
      date: DateTime.parse(map['date']),
      matiereId: map['matiereId'],
    );
  }

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(date as int);
}