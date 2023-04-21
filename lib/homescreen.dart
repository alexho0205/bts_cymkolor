import 'package:flutter/material.dart';
import 'package:bts_cymkolor/homescreen.dart';

import 'api/payment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text('Make Payment'),
              onPressed: () async {
                if (await new Payment().makePayment())
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 100.0,
                            ),
                            SizedBox(height: 10.0),
                            Text("Payment Successful!"),
                          ],
                        ),
                      ));
                else
                  AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            Text("Payment Failed"),
                          ],
                        ),
                      ],
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
