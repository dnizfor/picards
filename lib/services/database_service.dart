import 'package:path/path.dart';
import 'package:picards/models/deck_model.dart';
import 'package:picards/models/flashcard_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static late Database db;

  static Future<void> initializeDatabase() async {
    final path = join(await getDatabasesPath(), 'picards_database.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS decks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS flashcards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            word TEXT NOT NULL,
            mean TEXT NOT NULL,
            example TEXT NOT NULL,
            exampleMean TEXT NOT NULL,
            imagePath TEXT NOT NULL,
            deckId INTEGER NOT NULL,
            FOREIGN KEY(deckId) REFERENCES decks(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  static Future<int> onSaveNewCollection(
    String newDeckName,
    List<Flashcard> flashcardList,
  ) async {
    // 1. Deck'i ekle
    final deckId = await db.insert('decks', {'name': newDeckName});

    // 2. Her flashcard'ı ekle
    for (final flashcard in flashcardList) {
      flashcard.deckId = deckId;
      await DatabaseService.db.insert('flashcards', flashcard.toMap());
    }

    return deckId;
  }

  static Future<List<Deck>> getAllDecks() async {
    final List<Map<String, dynamic>> result = await db.query('decks');
    return result.map((map) => Deck.fromMap(map)).toList();
  }

  static Future<List<Flashcard>> getFlashcardsByDeckId(int deckId) async {
    final List<Map<String, dynamic>> result = await db.query(
      'flashcards',
      where: 'deckId = ?',
      whereArgs: [deckId],
    );

    return result.map((map) => Flashcard.fromMap(map)).toList();
  }

  static Future<void> updateExistingCollection(
    Deck newDeck,
    List<Flashcard> flashcardList,
  ) async {
    if (newDeck.id == null) {
      throw Exception('Cannot update a deck without an ID.');
    }

    // 1. Deck adını güncelle
    await db.update(
      'decks',
      {'name': newDeck.name},
      where: 'id = ?',
      whereArgs: [newDeck.id],
    );

    // 2. Mevcut flashcard'ları al
    final existingFlashcards = await getFlashcardsByDeckId(newDeck.id!);

    // 3. Silinecek flashcard'ları belirle ve sil
    final flashcardsToDelete = existingFlashcards.where(
      (existingCard) =>
          !flashcardList.any((newCard) => newCard.id == existingCard.id),
    );
    for (final flashcard in flashcardsToDelete) {
      await db.delete('flashcards', where: 'id = ?', whereArgs: [flashcard.id]);
    }

    // 4. Eklenecek veya güncellenecek flashcard'ları belirle ve ekle/güncelle
    for (final flashcard in flashcardList) {
      flashcard.deckId = newDeck.id!; // Deck ID'sini set et

      if (flashcard.id == null) {
        // Yeni flashcard, ekle
        await db.insert('flashcards', flashcard.toMap());
      } else {
        // Mevcut flashcard, güncelle
        await db.update(
          'flashcards',
          flashcard.toMap(),
          where: 'id = ?',
          whereArgs: [flashcard.id],
        );
      }
    }
  }

  static Future<void> deleteDeckById(int deckId) async {
    await db.delete('decks', where: 'id = ?', whereArgs: [deckId]);
  }
}
