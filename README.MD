<p align="center">
  <img src="https://github.com/user-attachments/assets/116c95b6-903d-4cf5-bf86-f59983819a76" width="220"/>
  <img src="https://github.com/user-attachments/assets/5bc19256-f1ce-4415-b27c-9491a91dd812" width="220"/>
  <img src="https://github.com/user-attachments/assets/bb6d1051-f04e-4d07-802c-500b425387d0" width="220"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/ee9181a5-2f1b-4832-8471-cb8416b5558c" width="220"/>
  <img src="https://github.com/user-attachments/assets/910046b1-1c33-439e-880a-47737a64c359" width="220"/>
  <img src="https://github.com/user-attachments/assets/4d10d4c4-27a5-49bd-92b4-dbed168e415f" width="220"/>
</p>

# Picards AI

> Build a vocabulary deck once. Practice it in five different ways.

Picards AI is a Flutter-based language-learning app that turns vocabulary into
interactive flashcards, image challenges, contextual exercises, and AI-generated
stories. Choose your native and target languages, create custom decks, and keep
practicing with short, varied sessions.

## Highlights

- **Custom vocabulary decks** — create, edit, and delete decks stored locally
  on the device.
- **AI-assisted card creation** — generate example sentences, translations, and
  memorable illustrations for new words.
- **Five practice modes**
  - Classic flashcards
  - Translation quizzes
  - Find the word from an image
  - Fill-in-the-blank exercises
  - Contextual question-and-answer practice
- **Story Time** — generate a story that naturally uses words from your decks.
- **Daily Marathon** — practice a fresh collection of words through multiple
  exercise types.
- **Multi-language onboarding** — independently select the language you speak
  and the language you want to learn.
- **Offline persistence** — decks and cards are saved in a local SQLite
  database.

## Built With

- [Flutter](https://flutter.dev/) and Dart
- [Firebase AI Logic](https://firebase.google.com/docs/ai-logic) with Gemini
- [Firebase Storage](https://firebase.google.com/docs/storage)
- SQLite (`sqflite`) for local data
- Provider for state management
- Shared Preferences for onboarding and language settings

## Getting Started

### Prerequisites

Before running the project, install:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) with Dart 3.8.1 or
  newer
- Android Studio or Xcode, depending on your target platform
- [Firebase CLI](https://firebase.google.com/docs/cli) and
  [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup)
- A Firebase project with AI Logic and Storage enabled

Check that your Flutter environment is ready:

```bash
flutter doctor
```

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/dnizfor/picards.git
   cd picards
   ```

2. Install the dependencies:

   ```bash
   flutter pub get
   ```

3. Connect the app to your own Firebase project:

   ```bash
   flutterfire configure
   ```

   This generates the platform-specific Firebase configuration and updates
   `lib/firebase_options.dart`. Ensure that your Firebase project also contains
   the required Android/iOS configuration files.

4. In the Firebase console:

   - Enable **Firebase AI Logic** with the Vertex AI Gemini API provider.
   - Enable **Firebase Storage**.
   - Configure Storage rules appropriate for your environment.

5. Run the app:

   ```bash
   flutter run
   ```

## How It Works

1. Select your native language and the language you want to learn.
2. Create a deck and add vocabulary.
3. Picards generates examples and illustrations to enrich each card.
4. Pick a deck and choose a practice mode.
5. Reinforce your vocabulary through quizzes, stories, or a full marathon.

## Project Structure

```text
lib/
├── models/       # Deck and flashcard data models
├── providers/    # Language and practice state
├── screens/      # Main application screens
├── services/     # SQLite, Firebase AI, and email services
├── utils/        # Shared helpers and enums
└── widgets/      # Reusable UI and exercise components

assets/
├── icon/         # Application icon
├── jsons/        # Bundled vocabulary data
├── lotties/      # Interface animations
└── sounds/       # Practice feedback effects
```

## Development

Run static analysis and tests before submitting changes:

```bash
flutter analyze
flutter test
```

Create a release build for your target platform:

```bash
flutter build apk
# or
flutter build ios
```

## Notes

- An internet connection is required for AI generation, translation, and remote
  image retrieval.
- AI-generated content may occasionally be inaccurate; review it before relying
  on it for learning.
- Firebase usage may incur costs depending on your project plan and traffic.
- Do not commit private credentials or production secrets to the repository.

## Contributing

Contributions are welcome. Fork the repository, create a focused branch, and
open a pull request with a clear description of your changes.

