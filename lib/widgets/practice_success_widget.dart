import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:picards/screens/deck_list_screen.dart';
import 'package:audioplayers/audioplayers.dart';

class PracticeSuccessWidget extends StatefulWidget {
  const PracticeSuccessWidget({super.key});

  @override
  State<PracticeSuccessWidget> createState() => _PracticeSuccessWidgetState();
}

class _PracticeSuccessWidgetState extends State<PracticeSuccessWidget> {
  AudioPlayer player = AudioPlayer();

  Future<void> playWrongSound() async {
    await player.play(AssetSource('sounds/victory_effect.mp3'));
  }

  @override
  void initState() {
    super.initState();
    playWrongSound();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DeckListScreen()),
          (route) => false, // tüm öncekileri siler
        ),
        shape: const CircleBorder(),
        child: const Icon(
          Ionicons.chevron_forward,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: SizedBox.expand(
        child: Container(
          color: Theme.of(context).colorScheme.shadow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lotties/trophy.json',
                fit: BoxFit.cover,
                width: 400,
                repeat: false,
              ),
              Text(
                'Mission Successful',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
