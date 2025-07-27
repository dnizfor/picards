class Deck {
  final int? id; // Otomatik artan ID, veritabanı tarafından atanır
  String name; // Deste adı

  Deck({this.id, required this.name});

  /// Veritabanına yazmak için: Deck → Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  /// Veritabanından okurken: Map → Deck
  factory Deck.fromMap(Map<String, dynamic> map) {
    return Deck(id: map['id'], name: map['name']);
  }

  @override
  String toString() => 'Deck(id: $id, name: $name)';
}
