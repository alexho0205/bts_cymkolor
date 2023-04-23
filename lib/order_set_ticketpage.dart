import 'dart:ffi';

import 'package:flutter/material.dart';
import 'api/g2rail_api_client.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'api/model/search_price_filter.dart';
import 'constent.dart';

class OrderSetTicketPage extends StatefulWidget {
  @override
  _OrderSetTicketPageState createState() => _OrderSetTicketPageState();
}

class _OrderSetTicketPageState extends State<OrderSetTicketPage> {
  final _formKey = GlobalKey<FormState>();

  int _ticketCount = 1;
  String _email = "";
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  SearchPriceFillterModel? _isGetBookingCode;

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
                  if (value == null || value.isEmpty) {
                    return '請輸入信箱';
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
              Center(
                child: _isLoading ? const CircularProgressIndicator() :
                    _isGetBookingCode == null ?
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      var prePageArgs = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
                      var ticketType = prePageArgs['travelSetType'];
                      setState(() {
                        _isLoading = true;
                      });
                      _getRailwaySet(_ticketCount, _selectedDate, ticketType).then((value) => {
                        setState(() {
                          _isLoading = false;
                          _isGetBookingCode = value;
                        })
                      }, onError: (error) => {
                        setState(() {
                          _isLoading = false;
                          _isGetBookingCode = null;
                        })
                      });
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('請輸入正確的資料')));
                    }
                  },
                  child: const Text('查詢'),
                ) :
                ElevatedButton(
                  onPressed: () {
                  },
                  child: const Text('去付款'),
                )
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

  Future<SearchPriceFillterModel?> _getRailwaySet(int ticketCount, DateTime date, String ticketType) async {

    String dateStr = DateFormat('yyyy/MM/dd').format(date.add(const Duration(days: 1)));
    String from = "", to = "";
    if(ticketType == order_set_2_title) {
      from = "CT_LV7D0LYK2";
      to = "CT_LV7D1LOK2";
    } else {

    }

    var client = GrailApiClient(
        httpClient: http.Client(),
        baseUrl: "http://alpha.api.g2rail.com",
        apiKey: "fa656e6b99d64f309d72d6a8e7284953",
        secret: "9a52b1f7-7c96-4305-8569-1016a55048bc");

    // 取 key
    var rtn = await client.getSolutions(
        from, to, dateStr, "10:00", ticketCount, 0);

    SearchPriceFillterModel? searchPriceFilterModel;
    if(rtn != "") {
      var rtn2 = await client.getAsyncResult(rtn.toString());
      searchPriceFilterModel = client.getAsyncResultPrice(rtn2); // 最低價
    }

    return searchPriceFilterModel;
  }

}