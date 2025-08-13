import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:picards/navigation.dart';
import 'package:picards/providers/language_provider.dart';
import 'package:picards/utils/utils.dart';
import 'package:picards/widgets/language_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, this.step});
  final int? step;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List languages = [];
  String nativeLanguageCode = '';
  String targetLanguageCode = '';
  int step = 0;
  String selectedLanguageCode = '';

  Future<void> onSave(context, provider) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (widget.step != null) {
      if (widget.step == 0) {
        await prefs.setString('nativeLanguageCode', nativeLanguageCode);
        provider.setNativeLanguageCode(nativeLanguageCode);
      } else {
        await prefs.setString('targetLanguageCode', targetLanguageCode);
        provider.setTargetLanguageCode(targetLanguageCode);
      }
      Navigator.pop(context);

      return;
    }
    await prefs.setBool('showHome', true);
    await prefs.setString('nativeLanguageCode', nativeLanguageCode);
    await prefs.setString('targetLanguageCode', targetLanguageCode);
    provider.setNativeLanguageCode(nativeLanguageCode);
    provider.setTargetLanguageCode(targetLanguageCode);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Navigation()),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.step == 0) {
      setState(() {
        step = 0;
      });
    } else if (widget.step == 1) {
      setState(() {
        step = 1;
      });
    }
    setState(() {
      languages = Utils.languagesData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.step == null) {
            if (step == 0) {
              setState(() {
                step = 1;
              });
            } else {
              onSave(context, languageProvider);
            }
          } else {
            onSave(context, languageProvider);
          }
          selectedLanguageCode = '';
        },
        shape: CircleBorder(),
        child: Icon(Ionicons.chevron_forward, color: Colors.white, size: 30),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF121212),
        surfaceTintColor: Color(0xFF121212),
        title: Center(
          child: Text(
            step == 0 ? "Native Language" : "Target Language",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: [
              Container(
                color: Color(0xFF121212),
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  step == 0
                      ? "This language will be used for instructions, explanations, and translations throughout the app. You can change it anytime later in the settings."
                      : 'This language will be used for flashcards and translations. You can change it anytime later in the settings.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),

              SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: languages.length,
                  itemBuilder: (builderContext, index) {
                    return LanguageCard(
                      title: languages[index]['name'],
                      code: languages[index]['code'],
                      isSelected:
                          selectedLanguageCode == languages[index]['code'],
                      onPress: () {
                        selectedLanguageCode = languages[index]['code'];
                        if (step == 0) {
                          setState(() {
                            nativeLanguageCode = languages[index]['code'];
                          });
                        } else {
                          setState(() {
                            targetLanguageCode = languages[index]['code'];
                          });
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
