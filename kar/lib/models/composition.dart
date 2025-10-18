class Composition {
  final int? id;
  final String type;
  final DateTime date;

  Composition({
    this.id,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'date': date.toIso8601String(),
    };
  }

  factory Composition.fromMap(Map<String, dynamic> map) {
    return Composition(
      id: map['id'],
      type: map['type'],
      date: DateTime.parse(map['date']),
    );
  }

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(date as int);
}