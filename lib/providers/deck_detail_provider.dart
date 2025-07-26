// import 'package:flutter/material.dart';
// import 'package:picards/models/flashcard_model.dart';

// class DeckDetailProvider extends ChangeNotifier {
//   String deckName = "";
//   List<Flashcard> flashcardList = [];

//   void setDeckName(String newDeckName) {
//     deckName = newDeckName;
//     notifyListeners();
//   }

//   void addEmptyFlashcard() {
//     final Flashcard newFlashcard = Flashcard();
//     flashcardList = [...flashcardList, newFlashcard];
//     notifyListeners();
//   }

//   void deleteFlashcard(Flashcard flashcardToDelete) {
//     flashcardList = flashcardList
//         .where((fc) => fc.id != flashcardToDelete.id)
//         .toList();
//     notifyListeners();
//   }

//   void updateFlashcard(Flashcard updatedFlashcard) {
//     final index = flashcardList.indexWhere(
//       (fc) => fc.id == updatedFlashcard.id,
//     );
//     if (index != -1) {
//       flashcardList[index] = updatedFlashcard;
//       flashcardList = [...flashcardList];
//       notifyListeners();
//     }
//   }
// }
