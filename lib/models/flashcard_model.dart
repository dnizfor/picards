class Flashcard {
  int? id; // Otomatik artan ID
  String? word;
  String? mean;
  String? example;
  String? exampleMean;
  String? imagePath;
  int? deckId; // Bağlı olduğu deck’in ID’si

  Flashcard({
    this.id,
    this.word,
    this.mean,
    this.example,
    this.exampleMean,
    this.imagePath,
    this.deckId,
  });

  /// Flashcard → Map (veritabanına yazmak için)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'mean': mean,
      'example': example,
      'exampleMean': exampleMean,
      'imagePath': imagePath,
      'deckId': deckId,
    };
  }

  /// Map → Flashcard (veritabanından okumak için)
  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      id: map['id'],
      word: map['word'],
      mean: map['mean'],
      example: map['example'],
      exampleMean: map['exampleMean'],
      imagePath: map['imagePath'],
      deckId: map['deckId'],
    );
  }

  @override
  String toString() {
    return 'Flashcard(id: $id, word: $word, mean: $mean, example: $example, exampleMean: $exampleMean, imagePath: $imagePath, deckId: $deckId)';
  }
}
