import 'package:flutter/material.dart';
import 'package:picards/providers/language_provider.dart';
import 'package:picards/screens/onboarding_screen.dart';
import 'package:picards/services/email_service.dart';
import 'package:picards/utils/utils.dart';
import 'package:picards/widgets/arrow_forward_button.dart';
import 'package:picards/widgets/language_card.dart';
import 'package:provider/provider.dart';
import 'package:store_redirect/store_redirect.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final nativeLanguageCode = context
        .read<LanguageProvider>()
        .nativeLanguageCode;
    final targetLanguageCode = context
        .read<LanguageProvider>()
        .targetLanguageCode;
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
                title: Utils.getLanguageFromCode(nativeLanguageCode),
                code: nativeLanguageCode,
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OnboardingScreen(),
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
                title: "English",
                code: targetLanguageCode,
                onPress: () {},
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
