import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:picards/screens/story_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryTimeButton extends StatefulWidget {
  const StoryTimeButton({super.key});

  @override
  State<StoryTimeButton> createState() => _StoryTimeButtonState();
}

class _StoryTimeButtonState extends State<StoryTimeButton> {
  bool isStoryReady = false;
  DateTime? lastClickTime;

  Future<void> _loadButtonState() async {
    final prefs = await SharedPreferences.getInstance();
    final lastClickMillis = prefs.getInt("lastClickTime");

    if (lastClickMillis != null) {
      lastClickTime = DateTime.fromMillisecondsSinceEpoch(lastClickMillis);
      final diff = DateTime.now().difference(lastClickTime!);

      if (diff.inHours >= 24) {
        setState(() => isStoryReady = true);
      } else {
        setState(() => isStoryReady = false);
      }
    } else {
      // İlk defa açılış
      setState(() => isStoryReady = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadButtonState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: isStoryReady
            ? [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.5),
                  spreadRadius: 3,
                  blurRadius: 6,
                ),
              ]
            : [],
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          onTap: () async {
            if (!isStoryReady) return;
            final prefs = await SharedPreferences.getInstance();
            await prefs.setInt(
              "lastClickTime",
              DateTime.now().millisecondsSinceEpoch,
            );

            if (!context.mounted) return;

            setState(() => isStoryReady = false);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => StoryScreen(writeNewStory: true),
              ),
            );
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isStoryReady ? 'Story Time!' : 'Story Not Ready!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: isStoryReady ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),

              isStoryReady
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Transform.translate(
                        offset: Offset(0, -40), // biraz yukarı kaydır
                        child: Lottie.asset(
                          'assets/lotties/story_animation.json',
                          repeat: true,
                          fit: BoxFit.cover,
                          width: 200,
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerRight,
                      child: Transform.translate(
                        offset: Offset(30, -40), // biraz yukarı kaydır
                        child: Lottie.asset(
                          'assets/lotties/author_animation.json',
                          repeat: true,
                          fit: BoxFit.cover,
                          width: 200,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
