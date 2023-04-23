import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api/model/download_ticket_model.dart';
import 'api/model/search_price_filter.dart';
import 'api/payment.dart';
import 'package:bts_cymkolor/api/g2rail_api_client.dart';
import 'models/passenger.dart';
import 'models/reservation.dart';

class OrderSetPayTicketPage extends StatefulWidget {
  @override
  _OrderSetPayTicketPageState createState() => _OrderSetPayTicketPageState();
}

class _OrderSetPayTicketPageState extends State<OrderSetPayTicketPage> {

  var _isLoading = false;
  int? _ticketCount;

  @override
  void initState() {
    super.initState();
    var prePageArgs = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var onlineOrdersModelId = prePageArgs['onlineOrdersModelId'];
    _onlineOrdersModel_ID = onlineOrdersModelId;
    var searchPriceFilterModel = prePageArgs['searchPriceFilterModel'] as SearchPriceFillterModel;
    var passenger = prePageArgs['g2railPassenger'] as G2railPassengers;
    var ticketCount = prePageArgs['ticketCount'];
    setState(() {
      // _onlineOrdersModel = data;
      _searchPriceFilterModel = searchPriceFilterModel;
      _g2railPassenger = passenger;
      _ticketCount = ticketCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('今日優惠套餐'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add first name, last name, cellphone, passport, birthday use TextFormFields here
                // first name
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "您的名字: ${_g2railPassenger?.firstName ?? ""}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // last name
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "您的姓氏: ${_g2railPassenger?.lastName ?? ""}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "您的性別: ${_g2railPassenger?.gender ?? ""}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "您的 Email: ${_g2railPassenger?.email ?? ""}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // cellphone
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "您的手機號碼: ${_g2railPassenger?.phone ?? ""}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // passport
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "您的護照號碼: ${_g2railPassenger?.passport ?? ""}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "您的生日: ${_g2railPassenger?.birthdate ?? ""}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "乘坐日期: ${_searchPriceFilterModel?.arrival ?? ""}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "套票張數: ${_ticketCount ?? 0}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "總金額/EUR: ${_searchPriceFilterModel?.price ?? 0}",
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                    child: _isLoading ? const CircularProgressIndicator() :
                    ElevatedButton(
                      onPressed: () {
                        // if (_onlineOrdersModel != null) {
                          setState(() {
                            _isLoading = true;
                          });
                          _stripePay().then((value) {
                              print(value);
                              _confirmReservationRailTicket().then((value) {
                                  print(value);
                                  _showDialog(Colors.green, "付款成功");
                                  setState(() {
                                    _isLoading = false;
                                  });
                              }, onError: (error) {
                                  print(error);
                                  _showDialog(Colors.red, "確認預訂車票失敗");
                                  setState(() {
                                    _isLoading = false;
                                  });
                              });
                          }, onError: (error) {
                              print(error);
                              _showDialog(Colors.red, "金流付款失敗");
                              setState(() {
                                _isLoading = false;
                              });
                          });
                        // }
                      },
                      child: const Text('確認付款'),
                    )
                ),
              ],
            ),
          ),
      ),
    );
  }

  final _client = GrailApiClient(
      httpClient: http.Client(),
      baseUrl: "http://alpha.api.g2rail.com",
      apiKey: "fa656e6b99d64f309d72d6a8e7284953",
      secret: "9a52b1f7-7c96-4305-8569-1016a55048bc");
  String? _onlineOrdersModel_ID;
  SearchPriceFillterModel? _searchPriceFilterModel;
  G2railPassengers? _g2railPassenger;

  Future<String> _stripePay() async {

    Reservation reservation = Reservation(
        email: "ichang.lee@cymmetrik.com",
        passengers: List<Passenger>.from([
          Passenger(
              lastName: _g2railPassenger!.lastName!,
              firstName: _g2railPassenger!.lastName!,
              birthdate: _g2railPassenger!.birthdate!,
              passport: _g2railPassenger!.passport!,
              email: _g2railPassenger!.email!,
              phone: _g2railPassenger!.phone!,
              gender: _g2railPassenger!.gender!)]),
        sections: List<String>.from(["bc_01","ABC123"]),
        seatReserved: true,
        memo: "123456789-00",
        paymentId: "123456789-00",
        ticketConfirmId: _onlineOrdersModel_ID!,
        PhoneNumber: _g2railPassenger!.phone!,
        PhoneVerified: false,
        currency: "EUR",
        amount: _searchPriceFilterModel!.price!);

    return await Payment().makeReservation(reservation);
  }

  Future<List<DownLoadTicketModel?>?> _confirmReservationRailTicket() async {
    var rtn6 =
    await _client.getConfirmAsyncResult(_onlineOrdersModel_ID!);
    if(rtn6?.id != null) {
      var rtn7 = await _client.getDownLoadTicketAsyncResult(rtn6!.id!);
      return rtn7;
    }
    else {
      return null;
    }
  }

  _showDialog(Color color, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: color,
                size: 100.0,
              ),
              const SizedBox(height: 10.0),
              Text(message),
            ],
          ),
        ));
  }
}