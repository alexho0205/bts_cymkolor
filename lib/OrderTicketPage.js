import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
const List<String> list = <String>['半票', '全票',];

class OrderTicketPage extends StatefulWidget {
  @override
  _OrderTicketPageState createState() => _OrderTicketPageState();
}

class _OrderTicketPageState extends State<OrderTicketPage> {
  final _formKey = GlobalKey<FormState>();
  String _ticketType = "";
  int _ticketCount = 0;
  String _email = "";
  DateTime _selectedDate = DateTime.now();

  var dropdownValue;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新天鵝堡門票'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: '您的 Email '),
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
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: '購買張數'),
                keyboardType: TextInputType.number,
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
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: '門票日期'),
                readOnly: true,
                onTap: _showDatePicker,
                validator: (value) {
                  if (_selectedDate == null) {
                    return 'Please select a date';
                  }
                  return null;
                },
                onChanged: (value){

                },
                controller: TextEditingController(
                    text: _selectedDate != null
                        ? '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'
                        : ''),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: Text('訂票'),
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

  void _submit() {
    print("submmited");
    print(_ticketCount);
    print(dropdownValue);
    print(_selectedDate);
    print(_email);
  }
}
