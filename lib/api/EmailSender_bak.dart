import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class EmailSender {
  static Future<void> sendEmail() async {
    // 創建郵件內容
    String username = 'your_email_address';
    String password = 'your_email_password';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username)
      ..recipients.add('recipient_email_address')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
    //final bytes = await rootBundle.load('assets/test.png');
    final bytes = await rootBundle.load('assets/test.png');
    final uint8List = bytes.buffer.asUint8List();
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/test.png');
    await file.writeAsBytes(uint8List);
    message.attachments.add(FileAttachment(file));
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
    }
  }
}
