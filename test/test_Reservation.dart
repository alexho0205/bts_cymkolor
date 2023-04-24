import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bts_cymkolor/models/reservation.dart';
import 'package:bts_cymkolor/models/passenger.dart';
import 'package:bts_cymkolor/api/payment.dart';

void main() async{
  Stripe.publishableKey = "pk_test_51MyFbGA3VDAE5Yfot311V4cGI1gZ8tyqpkYdBxJYVlujGPDbsWu64p02Mpukc1OUV3tQcRSv8zM4CUcXrxXar2UP00Gz7eWUP4";
  await Firebase.initializeApp();
  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");

  Reservation reservation = new Reservation(
      email: "ichang.lee@cymmetrik.com",
      passengers: new List<Passenger>.from([
        new Passenger(
            lastName: "zhang",
            firstName: "san",
            birthdate: "1986-09-01",
            passport: "A123456",
            email: "x@a.cn",
            phone: "+8615000367081",
            gender: "male"),
        new Passenger(
            lastName: "ichang",
            firstName: "lee",
            birthdate: "1975-07-21",
            passport: "N122771911",
            email: "leeichang@gmail.com",
            phone: "+886988033414",
            gender: "male")]),
      sections: new List<String>.from(["bc_01","ABC123"]),
      seatReserved: true,
      memo: "123456789-00",
      paymentId: "123456789-00",
      ticketConfirmId: "",
      PhoneNumber: "",
      PhoneVerified: false,
      currency: "USD",
      amount: 1000,
      ticketConfirmId: "",
      PhoneNumber:"" ,
      PhoneVerified : false
      );

    Payment payment = new Payment();
    String result = await payment.makeReservation(reservation);
    print(result);


}