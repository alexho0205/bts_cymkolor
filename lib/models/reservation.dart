import 'package:bts_cymkolor/models/passenger.dart';
import 'package:uuid/uuid.dart';

class Reservation {
  final String id;
  final String email;
  final List<Passenger> passengers;
  final List<String> sections;
  final bool seatReserved;
  final String memo;
  String? paymentId;
  final String currency;
  final int? amount;

  Reservation({
    String? id,
    required this.email,
    required this.passengers,
    required this.sections,
    required this.seatReserved,
    required this.memo,
    this.paymentId,
    required this.currency,
    required this.amount,
  }):id = id ?? Uuid().v4();

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      email: json['email'],
      passengers: (json['passengers'] as List)
          .map((item) => Passenger.fromJson(item))
          .toList(),
      sections: List<String>.from(json['sections']),
      seatReserved: json['seat_reserved'],
      memo: json['memo'],
      paymentId: json['payment_id'],
      currency: json['currency'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'passengers': passengers.map((item) => item.toJson()).toList(),
      'sections': sections,
      'seat_reserved': seatReserved,
      'memo': memo,
      'payment_id': paymentId,
      'currency': currency,
      'amount': amount,
    };
  }
}
