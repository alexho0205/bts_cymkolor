import 'package:bts_cymkolor/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'constent.dart';
import 'homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'firebase_options.dart';
import 'order_ticketpage.dart';
import 'package:bts_cymkolor/ui/smsValidateForm.dart';
import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Assign publishable key to flutter_stripe
  Stripe.publishableKey = "pk_test_51MyFbGA3VDAE5Yfot311V4cGI1gZ8tyqpkYdBxJYVlujGPDbsWu64p02Mpukc1OUV3tQcRSv8zM4CUcXrxXar2UP00Gz7eWUP4";

  //FlutterServicesBinding.ensureInitialized();

  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final routes = <String, WidgetBuilder>{ // map 關係 => keyStr : View Widget
    order_page: (context) => OrderTicketPage(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Random random = new Random();
    int number = random.nextInt(9000) + 1000;
    String randomString = number.toString();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TravelPage(),//SmsValidateForm("+886988033414",randomString),
      routes: routes,
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       //initial route
//       home: TravelPage(),
//     );
//   }
// }
