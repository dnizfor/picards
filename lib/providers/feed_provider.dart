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

  void setSelectedDeckId(int newSelectedDeckId) {
    selectedDeckId = newSelectedDeckId;
    notifyListeners();
    updateFlashCardList();
  }

  void updateDeckList() async {
    List<Deck> updatedDeckList = await DatabaseService.getAllDecks();
    deckList = updatedDeckList;
    notifyListeners();
    if (!updatedDeckList.any((deck) => deck.id == selectedDeckId) &&
        updatedDeckList.isNotEmpty) {
      updateFlashCardList();
      setSelectedDeckId(updatedDeckList[0].id!);
    }
  }

  void updateFlashCardList() async {
    List<Flashcard> updatedFlashCardList = [];
    if (selectedDeckId != null) {
      updatedFlashCardList = await DatabaseService.getFlashcardsByDeckId(
        selectedDeckId!,
      );
    }
    flashcardList = updatedFlashCardList;
    notifyListeners();
  }
}
