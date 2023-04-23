import 'package:flutter/material.dart';
import 'package:bts_cymkolor/homescreen.dart';
import 'api/payment.dart';
import 'package:bts_cymkolor/models/ticket.dart';
import 'package:bts_cymkolor/models/reservation.dart';
import 'package:bts_cymkolor/models/passenger.dart';

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
                /*Ticket ticket = Ticket(
                  adultTickets: 2,
                  halfTickets: 3,
                  email: "ichang.lee@cymmetrik.com",
                  paymentId: "",
                  haveGetTicket: false,
                  downloadCount: 0,
                  downloadUrl: "",
                  currency: "USD",
                  amount: 100,
                );*/
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
                    PhoneNumber: "+886988033414",
                    PhoneVerified: false);
                if (await Payment().makeReservation(reservation)!="") {
                  showDialog(
                      context: context,
                      builder: (_) =>  AlertDialog(
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
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.red,
                              size: 100.0,
                            ),
                            SizedBox(height: 10.0),
                            Text("Payment Error!"),
                          ],
                        ),
                      ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
