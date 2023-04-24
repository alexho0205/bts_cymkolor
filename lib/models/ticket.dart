import 'package:uuid/uuid.dart';

class Ticket {
  final String id;
  final int adultTickets;
  final int halfTickets;
  final String email;
  String paymentId;
  final bool haveGetTicket;
  final int downloadCount;
  final String downloadUrl;
  final String currency;
  final double amount;
  final DateTime useDate;
  final String sourceId;

  Ticket({
    String? id,
    required this.adultTickets,
    required this.halfTickets,
    required this.email,
    required this.paymentId,
    required this.haveGetTicket,
    required this.downloadCount,
    required this.downloadUrl,
    required this.currency,
    required this.amount,
    required this.useDate,
    this.sourceId = "",
  }) : id = id ?? Uuid().v4(); // 使用Uuid().v4()生成唯一ID

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'],
      adultTickets: map['adult_tickets'],
      halfTickets: map['half_tickets'],
      email: map['email'],
      paymentId: map['payment_id'],
      haveGetTicket: map['have_get_ticket'],
      downloadCount: map['download_count'],
      downloadUrl: map['download_url'],
      currency: map['currency'],
      amount: map['amount'],
      useDate: DateTime.parse(map['use_date']),
      sourceId: map['source_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'adult_tickets': adultTickets,
      'half_tickets': halfTickets,
      'email': email,
      'payment_id': paymentId,
      'have_get_ticket': haveGetTicket,
      'download_count': downloadCount,
      'download_url': downloadUrl,
      'currency': currency,
      'amount': amount,
      'use_date': useDate.toIso8601String(),
      'source_id': sourceId,
    };
  }
}
