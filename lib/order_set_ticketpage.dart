import 'dart:ffi';

import 'package:flutter/material.dart';
import 'api/payment.dart';
import 'models/ticket.dart';

class OrderSetTicketPage extends StatefulWidget {
  @override
  _OrderSetTicketPageState createState() => _OrderSetTicketPageState();
}

class _OrderSetTicketPageState extends State<OrderSetTicketPage> {
  final _formKey = GlobalKey<FormState>();
  int _ticketCount = 1;
  String _email = "";
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('今日優惠套餐'),
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
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: '套票張數'),
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
                decoration: const InputDecoration(labelText: '乘坐日期'),
                readOnly: true,
                onTap: _showDatePicker,
                validator: (value) {
                  return null;
                },
                onChanged: (value){
                },
                controller: TextEditingController(
                    text: '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {  },
                child: const Text('查詢'),
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
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _getRailwaySet(Int ticketCount, DateTime date) {

  }

}