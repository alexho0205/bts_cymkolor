import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class Payment {
  Map<String, dynamic>? paymentIntent;
  Future<bool> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('100', 'USD');
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
      return displayPaymentSheet();
    } catch (err) {
      return false;
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

