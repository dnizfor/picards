import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DrawCardButton extends StatefulWidget {
  const DrawCardButton({super.key});

  @override
  State<DrawCardButton> createState() => _DrawCardButtonState();
}

class _DrawCardButtonState extends State<DrawCardButton> {
  Future<void> onTap() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: SizedBox.expand(
          child: ColoredBox(
            color: Theme.of(context).colorScheme.shadow,
            child: Lottie.asset(
              'assets/lotties/cards_loading_animation.json',
              repeat: true,
              width: 300,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );

    // Navigator.of(context).push(
    //             MaterialPageRoute(
    //               builder: (context) => StoryScreen(writeNewStory: true),
    //             ),
    //           )
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.5),
            spreadRadius: 3,
            blurRadius: 6,
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          onTap: onTap,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Draw New Cards!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
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
