import 'package:flutter/material.dart';
import 'package:bts_cymkolor/homescreen.dart';

import 'api/payment.dart';
import 'package:bts_cymkolor/models/ticket.dart';

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
                Ticket ticket = Ticket(
                  adultTickets: 2,
                  halfTickets: 3,
                  email: "ichang.lee@cymmetrik.com",
                  paymentId: "",
                  haveGetTicket: false,
                  downloadCount: 0,
                  downloadUrl: "",
                  currency: "USD",
                  amount: 100,
                );
                if (await new Payment().makePayment(ticket)!="")
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
