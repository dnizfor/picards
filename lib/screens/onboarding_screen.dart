import 'package:flutter/material.dart';
import 'package:picards/navigation.dart';
import 'package:picards/providers/language_provider.dart';
import 'package:picards/utils/utils.dart';
import 'package:picards/widgets/language_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List languages = [];

  languageCardOnPress(nativeLanguageCode, context, provider) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showHome', true);
    await prefs.setString('nativeLanguageCode', nativeLanguageCode);
    await prefs.setString('targetLanguageCode', 'en');
    provider.setNativeLanguageCode(nativeLanguageCode);
    provider.setTargetLanguageCode("en");
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const Navigation()));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      languages = Utils.languagesData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Color(0xFF121212),
        surfaceTintColor: Color(0xFF121212),
        title: Center(
          child: Text(
            "Native Language",
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
                  "This language will be used for instructions, explanations, and translations throughout the app. You can change it anytime later in the settings.",
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
                      onPress: () => languageCardOnPress(
                        languages[index]['code'],
                        context,
                        languageProvider,
                      ),
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
