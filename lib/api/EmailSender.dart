import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mailer/src/entities/attachment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bts_cymkolor/models/ticket.dart';

class TicketMailer {

  TicketMailer();
  final qrKey = GlobalKey();

  Future<File> generateQrImageFile(String url) async {
    // Create the QR code painter
    final qrPainter = QrPainter(
      data: url,
      version: QrVersions.auto,
      gapless: false,
      color: Colors.black,
      emptyColor: Colors.white,
    );

    // Create a PictureRecorder and a Canvas with the specified size
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final canvas = ui.Canvas(pictureRecorder, Rect.fromLTWH(0.0, 0.0, 200.0, 200.0));

    // Paint the QR code on the canvas
    qrPainter.paint(canvas, Size(200.0, 200.0));

    // Get the rendered image
    final ui.Image qrImage = await pictureRecorder.endRecording().toImage(200, 200);

    // Convert the image to bytes (PNG format)
    ByteData? byteData = await qrImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Get the temporary directory and create a file
    Directory tempDir = await getTemporaryDirectory();
    File file = File('${tempDir.path}/qr_code.png');

    // Write the image bytes to the file
    await file.writeAsBytes(pngBytes);

    return file;
  }

  Future<void> sendTicketEmail(Ticket ticket) async {


    final ticketUrl = 'https://ticket.cymcolor.com/?uid=ED92AE1A-E1EA-4274-99F2-2402317D24B6';
    File qrImage = await generateQrImageFile(ticketUrl);

    // Read the file bytes
    List<int> qrImageBytes = qrImage.readAsBytesSync();

    // Create a ContentType object
    ContentType contentType = ContentType('image', 'png');
    // Create a MemoryAttachment object and set the headers
    FileAttachment inlineImageAttachment = FileAttachment(
      qrImage,
      contentType: contentType.toString(),
    );

    // 使用自定义SMTP服务器配置
    final smtpServer = SmtpServer(
      '${dotenv.env['MAIL_HOST']}',
      port: int.parse('${dotenv.env['MAIL_PORT']}'), // 使用适当的端口号，通常是 25, 465 或 587
      username: '${dotenv.env['MAIL_USERNAME']}',
      password: '${dotenv.env['MAIL_PASSWORD']}',
      ssl: false, // 如果需要SSL/TLS，请将其设置为true
      ignoreBadCertificate: false, // 如果需要忽略证书错误，请将其设置为true
    );

    final message = Message()
      ..from = Address(smtpServer.username?? '', 'Ticket Sender')
      ..recipients.add(ticket.email)
      ..subject = 'Ticket Booking Notice: 2023/5/1 Neuschwanstein'
      ..html = '''
        <h1>Ticket Booking Notice</h1>
        <p>You have successfully booked your tickets for 2023/5/1 Neuschwanstein</p>
        <table border="1" cellpadding="5">
          <thead>
            <tr>
              <th>Ticket Type</th>
              <th>Quantity</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>All Tickets</td>
              <td>${ticket.adultTickets}</td>
            </tr>
            <tr>
              <td>Half ticket</td>
              <td>${ticket.halfTickets}</td>
            </tr>
          </tbody>
        </table>
        <p>Total amount: ${ticket.amount} ${ticket.currency}</p>
        ''';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Message not sent.');
      print(e.toString());
    }
  }
}


