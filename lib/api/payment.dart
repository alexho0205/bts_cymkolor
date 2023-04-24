import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:bts_cymkolor/models/ticket.dart';
import 'package:bts_cymkolor/models/reservation.dart';
import 'package:bts_cymkolor/repository/ticketsRepository.dart';
import 'package:bts_cymkolor/repository/reservation_repository.dart';
import 'package:bts_cymkolor/api/EmailSender.dart';
import 'package:mailer/mailer.dart';

class Payment {
  Map<String, dynamic>? paymentIntent;
  Future<String> makePayment(Ticket ticket) async {
    try {
      paymentIntent =
          await createPaymentIntent((ticket.amount).toInt().toString(), ticket.currency);
      String paymentIntentId = paymentIntent!['id'];
      print('PaymentIntent ID: $paymentIntentId');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
/*              applePay: PaymentSheetApplePay(
                merchantCountryCode: 'TW',
              ),
              googlePay: PaymentSheetGooglePay(
                merchantCountryCode: 'TW',
                testEnv: true,
              ),*/
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Ikay'))
          .then((value) {
        print('Payment Sheet Initialized {value}');
      });

      //STEP 3: Display Payment sheet
      String result = "";
      if (await displayPaymentSheet()) {
        try {
          TicketsRepository ticketsRepository = TicketsRepository();
          ticket.paymentId = paymentIntentId;
          await ticketsRepository.addTicket(ticket).then((value) async {
            TicketMailer ticketMailer = TicketMailer();
            await ticketMailer.sendTicketEmail(ticket).then((value) {
              print('Ticket sent');
              result = paymentIntentId;
            });
          });
        } catch (e) {
          print('$e');
          result = "";
        }
        return result;
      } else {
        return "";
      }
    } catch (err) {
      return "";
      //throw Exception(err);
    }
  }

  Future<String> makeReservation(Reservation reservation) async {
    try {
      paymentIntent = await createPaymentIntent(
          (reservation.amount).toInt().toString(), reservation.currency);
      String paymentIntentId = paymentIntent!['id'];
      print('PaymentIntent ID: $paymentIntentId');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
/*              applePay: PaymentSheetApplePay(
                merchantCountryCode: 'TW',
              ),
              googlePay: PaymentSheetGooglePay(
                merchantCountryCode: 'TW',
                testEnv: true,
              ),*/
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Ikay'))
          .then((value) {
        print('Payment Sheet Initialized {value}');
      });

      //STEP 3: Display Payment sheet
      String result = "";
      if (await displayPaymentSheet()) {
        try {
          ReservationRepository reservationRepository = ReservationRepository();
          reservation.paymentId = paymentIntentId;
          await reservationRepository
              .createReservation(reservation)
              .then((value) async {
            TicketMailer ticketMailer = TicketMailer();
            Message message = ticketMailer.GetEmailMessage<Reservation>(
                MailType.Reservation, reservation);
            await ticketMailer.sendEmail(message).then((value) async {
              Message message = ticketMailer.GetEmailMessage<Reservation>(
                  MailType.Reservation_inner, reservation);
              await ticketMailer.sendEmail(message).then((value) {
                print('Ticket sent');
                result = paymentIntentId;
              });
            });
          });
        } catch (e) {
          print('$e');
          result = "";
        }
        return result;
      } else {
        return "";
      }
    } catch (err) {
      return "";
      //throw Exception(err);
    }
  }

  Future<bool> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        paymentIntent = null;
        return true;
      }).onError((error, stackTrace) {
        //throw Exception(error);
        return false;
      });
      return true;
    } on StripeException catch (e) {
      print('Error is:---> $e');
      return false;
    } catch (e) {
      print('$e');
      return false;
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
