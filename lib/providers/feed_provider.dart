import 'package:flutter/material.dart';
import 'package:picards/models/deck_model.dart';
import 'package:picards/models/flashcard_model.dart';
import 'package:picards/services/database_service.dart';
import 'package:picards/utils/enums/practice_type_enum.dart';

class FeedProvider extends ChangeNotifier {
  PracticeType practiceType = PracticeType.flashcard;
  int? selectedDeckId;
  List<Deck> deckList = [];
  List<Flashcard> flashcardList = [];

  void setPracticeType(PracticeType newPracticeType) {
    practiceType = newPracticeType;
    notifyListeners();
  }

  void setSelectedDeckId(int newSelectedDeckId) async {
    selectedDeckId = newSelectedDeckId;
    notifyListeners();
    await updateFlashCardList();
    return;
  }

  Future<void> updateDeckList() async {
    List<Deck> updatedDeckList = await DatabaseService.getAllDecks();
    deckList = updatedDeckList;
    notifyListeners();
    if (!updatedDeckList.any((deck) => deck.id == selectedDeckId) &&
        updatedDeckList.isNotEmpty) {
      setSelectedDeckId(updatedDeckList[0].id!);
    }
    await updateFlashCardList();
  }

  Future<void> updateFlashCardList() async {
    List<Flashcard> updatedFlashCardList = [];
    if (selectedDeckId == null && deckList.isNotEmpty) {
      setSelectedDeckId(deckList[0].id!);
    } else if (deckList.isEmpty) {
      updatedFlashCardList = [];
    } else {
      updatedFlashCardList = await DatabaseService.getFlashcardsByDeckId(
        selectedDeckId!,
      );
    }
    flashcardList = updatedFlashCardList;
    notifyListeners();
  }
}
