import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typing_indicator/flutter_typing_indicator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:picards/providers/language_provider.dart';
import 'package:picards/services/vertex_ai_service.dart';
import 'package:provider/provider.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({super.key, required this.word, required this.goToNextPage});
  final String word;
  final Function goToNextPage;

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  late TextEditingController _controller;
  String question = '';
  List<Map<String, dynamic>> chat = [];
  bool loading = false;
  bool showTypingIndicator = false;
  AudioPlayer player = AudioPlayer();

  Future<void> playWrongSound() async {
    await player.play(AssetSource('sounds/errorEffect.mp3'));
  }

  Future<void> playCorrectSound() async {
    await player.play(AssetSource('sounds/successEffect.mp3'));
  }

  Future<void> onSend() async {
    final String userMessage = _controller.text;
    if (userMessage.trim() == '') return;
    if (userMessage.trim() == widget.word) {
      _controller.text = '';
      playWrongSound();
      setState(() {
        chat.add({'message': userMessage, 'role': 'user'});
      });
      setState(() {
        chat.add({'message': '❌😕🔄✨', 'role': 'assistant'});
      });
      return;
    }

    setState(() {
      showTypingIndicator = true;
    });
    _controller.text = '';
    setState(() {
      chat.add({'message': userMessage, 'role': 'user'});
    });

    final String responseData = await VertexAiService.checkUserAnswer(
      question,
      userMessage,
      widget.word,
    );
    final bool isResponseTrue = json.decode(responseData)['check'];
    setState(() {
      showTypingIndicator = false;
    });
    if (isResponseTrue) {
      playCorrectSound();
      setState(() {
        chat.add({'message': '🎉✅👍😊', 'role': 'assistant'});
      });
      await Future.delayed(Duration(seconds: 1));
      widget.goToNextPage();
    } else {
      playWrongSound();
      setState(() {
        chat.add({'message': '❌😕🔄✨', 'role': 'assistant'});
      });
    }
  }

  Future<void> getQuestion(String targetLanguage, String word) async {
    setState(() {
      loading = true;
    });
    final String response = await VertexAiService.createQuestionForWord(
      targetLanguage,
      word,
    );

    final String responseData = json.decode(response)['question'];
    if (!mounted) return;

    setState(() {
      loading = false;
      question = responseData;
    });
  }

  @override
  void initState() {
    _controller = TextEditingController();
    final String targetLanguage = Provider.of<LanguageProvider>(
      context,
      listen: false,
    ).targetLanguageCode;

    getQuestion(targetLanguage, widget.word);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 5 * MediaQuery.of(context).size.height / 12,
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: loading
                        ? LoadingAnimationWidget.staggeredDotsWave(
                            color: Theme.of(context).colorScheme.primary,
                            size: 70,
                          )
                        : AutoSizeText(
                            question,
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '(Answer using the word: ',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.word,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ')'),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: chat[index]['role'] == 'user'
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 2,
                          ),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(chat[index]['message']),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: chat.length,
                  ),

                  showTypingIndicator
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TypingIndicator(
                                backgroundColor: Colors.transparent,
                                duration: Duration(milliseconds: 1500),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: Theme.of(context).colorScheme.shadow,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Your Answer',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Material(
                    color: Colors.transparent,
                    shape: CircleBorder(),
                    child: Ink(
                      decoration: ShapeDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: onSend,
                        icon: Icon(Icons.send),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
