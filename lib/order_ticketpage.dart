import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'api/payment.dart';
import 'models/ticket.dart';
const List<String> list = <String>['半票', '全票',];

class OrderTicketPage extends StatefulWidget {
  final String title;
  final int price;
  final String currency;

  OrderTicketPage({
    required this.title,
    required this.price,
    required this.currency,
  });

  @override
  _OrderTicketPageState createState() => _OrderTicketPageState();
}

class _OrderTicketPageState extends State<OrderTicketPage> {
  final _formKey = GlobalKey<FormState>();
  int _ticketCount = 1;
  String _email = "";
  DateTime _selectedDate = DateTime.now();

  var dropdownValue = "全票";
  String _title = "新天鵝堡門票";
  int _price = 45;
  String _currency = "EUR";

  void initState() {
    super.initState();
    _title = widget.title;
    _price = widget.price;
    _currency = widget.currency;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: '您的 Email '),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null) {
                    return 'Please enter ticket count';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
                onChanged: (value){
                  _email = value;
                },
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: '購買張數'),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: '$_ticketCount'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter ticket count';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _ticketCount = int.parse(value!);
                },
                onChanged: (value){
                  _ticketCount = int.parse(value);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: '門票日期'),
                readOnly: true,
                onTap: _showDatePicker,
                validator: (value) {
                  // if (_selectedDate == null) {
                  //   return 'Please select a date';
                  // }
                  return null;
                },
                onChanged: (value){

                },
                controller: TextEditingController(
                    text:
                    '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _pay(_email, dropdownValue, _ticketCount);
                },
                child: const Text('訂票'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _pay(String email, String ticketType, int count) async {

    int adultTickets = 0;
    int halfTickets = 0;
    if (ticketType == "全票") {
      adultTickets = count;
    } else {
      halfTickets = count;
    }

    Ticket ticket = Ticket(
      adultTickets: adultTickets,
      halfTickets: halfTickets,
      email: email,
      paymentId: "",
      haveGetTicket: false,
      downloadCount: 0,
      downloadUrl: "",
      currency: _currency,
      amount: _price*count,
      useDate: _selectedDate,
    );

    if (await Payment().makePayment(ticket)!="") {
      showDialog(
          context: context,
          builder: (_) =>  AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
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
              children: const [
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
  }
}