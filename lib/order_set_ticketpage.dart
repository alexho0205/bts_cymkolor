import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'api/model/online_orders_model.dart';
import 'api/model/search_price_filter.dart';
import 'constent.dart';
import 'package:bts_cymkolor/api/g2rail_api_client.dart';

class OrderSetTicketPage extends StatefulWidget {
  @override
  _OrderSetTicketPageState createState() => _OrderSetTicketPageState();
}

const List<String> _genderDropdownContent = <String>['男', '女',];
class _OrderSetTicketPageState extends State<OrderSetTicketPage> {
  final _formKey = GlobalKey<FormState>();

  int _ticketCount = 1;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  // Add first name, last name, cellphone, passport, gender, birthday here
  // first name
  String _firstName = "";
  // last name
  String _lastName = "";
  String _email = "";
  // cellphone
  String _cellphone = "";
  // passport
  String _passport = "";
  // birthday
  DateTime _birthday = DateTime.now().add(Duration(days: -3650));
  // gender
  String _gender = "女";

  final _client = GrailApiClient(
  httpClient: http.Client(),
  baseUrl: "http://alpha.api.g2rail.com",
  apiKey: "fa656e6b99d64f309d72d6a8e7284953",
  secret: "9a52b1f7-7c96-4305-8569-1016a55048bc");

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
          child: SingleChildScrollView(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add first name, last name, cellphone, passport, birthday use TextFormFields here
                // first name
                TextFormField(
                  decoration: const InputDecoration(labelText: '您的名字'),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '請輸入名字';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstName = value!;
                  },
                  onChanged: (value){
                    _firstName = value;
                  },
                ),
                const SizedBox(height: 16),
                // last name
                TextFormField(
                  decoration: const InputDecoration(labelText: '您的姓氏'),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '請輸入姓氏';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _lastName = value!;
                  },
                  onChanged: (value){
                    _lastName = value;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButton<String>(
                  value: _gender,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      _gender = value!;
                    });
                  },
                  items: _genderDropdownContent.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
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
                // cellphone
                TextFormField(
                  decoration: const InputDecoration(labelText: '您的手機號碼'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '請輸入手機號碼';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _cellphone = value!;
                  },
                  onChanged: (value){
                    _cellphone = value;
                  },
                ),
                const SizedBox(height: 16),
                // passport
                TextFormField(
                  decoration: const InputDecoration(labelText: '您的護照號碼'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '請輸入護照號碼';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _passport = value!;
                  },
                  onChanged: (value){
                    _passport = value;
                  },
                ),
                const SizedBox(height: 16),
                // birthday
                TextFormField(
                  decoration: const InputDecoration(labelText: '您的生日'),
                  readOnly: true,
                  onTap: () {  _showDatePicker(_birthday, DateTime(1923), DateTime.now(), type: "birthday"); },
                  validator: (value) {
                    return null;
                  },
                  onChanged: (value){
                  },
                  controller: TextEditingController(
                      text: '${_birthday.year}-${_birthday.month}-${_birthday.day}'),
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
                  onTap: () {  _showDatePicker(_selectedDate, DateTime.now(), DateTime(2100)); },
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
                    _isGetTheCheapestTicket == null ?
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
                              _isGetTheCheapestTicket = value;
                            })
                          }, onError: (error) => {
                            setState(() {
                              _isLoading = false;
                              _isGetTheCheapestTicket = null;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('API 響應失敗')));
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
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setState(() {
                            _isLoading = true;
                          });
                          _bookingTicket().then((value) => {
                            setState(() {
                              _isLoading = false;
                              _isOnlineOrdersModel = value;
                            })
                          }, onError: (error) => {
                            setState(() {
                              _isLoading = false;
                              _isGetTheCheapestTicket = null;
                            })
                          });
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('請輸入正確的資料')));
                        }
                      },
                      child: const Text('去付款'),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDatePicker(DateTime initDate, DateTime firstDate, DateTime lastDate, { String type = "default"}) async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: initDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (pickedDate != null) {
      setState(() {
        if(type == "birthday") {
          _birthday = pickedDate;
        } else {
          _selectedDate = pickedDate;
        }
      });
    }
  }

  SearchPriceFillterModel? _isGetTheCheapestTicket;
  OnlineOrdersModel? _isOnlineOrdersModel;

  Future<SearchPriceFillterModel?> _getRailwaySet(int ticketCount, DateTime date, String ticketType) async {

    String dateStr = DateFormat('yyyy/MM/dd').format(date.add(const Duration(days: 1)));
    String from = "", to = "";
    if(ticketType == order_set_2_title) {
      from = "CT_LV7D0LYK2";
      to = "CT_LV7D1LOK2";
    } else {

    }

    // 取 key
    var rtn = await _client.getSolutions(
        from, to, dateStr, "10:00", ticketCount, 0);

    SearchPriceFillterModel? searchPriceFilterModel;
    if(rtn != "") {
      var rtn2 = await _client.getAsyncResult(rtn.toString(), retryCounts: 10);
      searchPriceFilterModel = _client.getAsyncResultPrice(rtn2); // 最低價
    }

    return searchPriceFilterModel;
  }

  Future<OnlineOrdersModel?> _bookingTicket() async {

    List<G2railPassengers> passengers = [];
    passengers.add(G2railPassengers(
        lastName: _lastName,
        firstName: _firstName,
        birthdate: DateFormat('yyyy-MM-dd').format(_birthday),
        passport: _passport,
        email: _email,
        phone: _cellphone,
        gender: _gender));
    List<String> sections = [_isGetTheCheapestTicket!.bookingcode!];

    var rtn3 = await _client.getOnlineOrders(
        passengers, sections, true, "partner_order_id");
    var rtn4 =
        await _client.getOrdersAsyncResult(rtn3);

    return rtn4;
  }
}