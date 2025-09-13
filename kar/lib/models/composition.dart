class Composition {
  final int? id;
  final String type;
  final int date;

  Composition({
    this.id,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'date': date,
    };
  }

  factory Composition.fromMap(Map<String, dynamic> map) {
    return Composition(
      id: map['id'],
      type: map['type'],
      date: map['date'],
    );
  }

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(date);
}