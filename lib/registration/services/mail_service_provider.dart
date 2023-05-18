import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


class MailService extends ChangeNotifier {
  void sendEmail(String mail) async {



  // As pointed by Justin in the comments, be careful what you store in the source code.
  // Be extra careful what you check into a public repository.
  // I'm merely giving the simplest example here.

  // Right now only SMTP transport method is supported.

  // Create a SMTP client configuration
  final smtpServer = gmail('riyamandal4u@gmail.com', 'qtezavmdmafmmltw');


  // Create the email message
  final message = Message()
    ..from = const Address('riyamandal4u@gmail.com', 'Riya Mandal')
    ..recipients.add(mail)
    ..subject = 'Test Email'
    ..text = 'Welcome, Thankyou for Registering with us';

  try {
    final sendReport = await send(message, smtpServer);
    // print('Email sent: ${sendReport.sent}');
  } catch (e) {
    print('Error sending email: $e');
  }
}


}