import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailService {
  Future<void> sendMail(String subject) async {
    final Email email = Email(
      subject: subject,
      recipients: ['vidolinai@viralmo.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}
