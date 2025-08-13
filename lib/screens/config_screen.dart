import 'package:flutter/material.dart';
import 'package:picards/providers/language_provider.dart';
import 'package:picards/screens/onboarding_screen.dart';
import 'package:picards/services/email_service.dart';
import 'package:picards/utils/utils.dart';
import 'package:picards/widgets/arrow_forward_button.dart';
import 'package:picards/widgets/language_card.dart';
import 'package:provider/provider.dart';
import 'package:store_redirect/store_redirect.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: ListView(
            children: [
              ArrowForwardButton(title: "Go Premium", onTap: () {}),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Native Language",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              LanguageCard(
                title: Utils.getLanguageFromCode(
                  languageProvider.nativeLanguageCode,
                ),
                code: languageProvider.nativeLanguageCode,
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OnboardingScreen(step: 0),
                    ),
                  );
                },
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Target Language",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              LanguageCard(
                title: Utils.getLanguageFromCode(
                  languageProvider.targetLanguageCode,
                ),
                code: languageProvider.targetLanguageCode,
                onPress: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OnboardingScreen(step: 1),
                  ),
                ),
              ),
              SizedBox(height: 10),

              ArrowForwardButton(
                title: "Rate Us",
                onTap: () => StoreRedirect.redirect(
                  androidAppId: "com.viralmo.vidolinai",
                  iOSAppId: "6742706069",
                ),
              ),
              SizedBox(height: 10),
              ArrowForwardButton(
                title: "Contac Us",
                onTap: () => EmailService().sendMail('Support Vidolin AI'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
