import 'package:bts_cymkolor/repository/reservation_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api/model/confrim_order_model.dart';
import 'api/model/download_ticket_model.dart';
import 'api/model/search_price_filter.dart';
import 'api/payment.dart';
import 'package:bts_cymkolor/api/g2rail_api_client.dart';
import 'models/passenger.dart';
import 'models/reservation.dart';

class OrderSetPayTicketPage extends StatefulWidget {

  final String onlineOrdersModelId;
  final SearchPriceFillterModel searchPriceFilterModel;
  final G2railPassengers g2railPassenger;
  final int ticketCount;

  OrderSetPayTicketPage({Key? key, required this.onlineOrdersModelId, required this.searchPriceFilterModel, required this.g2railPassenger, required this.ticketCount}) : super(key: key);

  @override
  _OrderSetPayTicketPageState createState() => _OrderSetPayTicketPageState();
}

class _OrderSetPayTicketPageState extends State<OrderSetPayTicketPage> {

  var _isLoading = false;
  int? _ticketCount;
  String? _localStartToEndDateString;

  @override
  void initState() {
    super.initState();
    _onlineOrdersModelID = widget.onlineOrdersModelId;

    var localStartDate = DateTime.parse(_searchPriceFilterModel!.departure!).toLocal();
    var durationHour = _searchPriceFilterModel!.duration!.hour!;
    var durationMinutes = _searchPriceFilterModel!.duration!.minutes!;
    var localEndDate = localStartDate.add(Duration(hours: durationHour)).add(Duration(minutes: durationMinutes));
    _localStartToEndDateString = "${localStartDate.year}-${localStartDate.month}-${localStartDate.day} ${localStartDate.hour}:${localStartDate.minute} -> ${localEndDate.year}-${localEndDate.month}-${localEndDate.day} ${localEndDate.hour}:${localEndDate.minute}";
    setState(() {
      _searchPriceFilterModel = widget.searchPriceFilterModel;
      _g2railPassenger = widget.g2railPassenger;
      _ticketCount = widget.ticketCount;
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
                    "乘坐時間: ${_localStartToEndDateString ?? ""}",
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
                    "總金額/EUR: ${((_searchPriceFilterModel?.price ?? 0) / 100)}",
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
                               var stripePayID = value;
                              _confirmReservationRailTicket().then((value) {

                                  if(value != null) {
                                    var confirmID = value.id ?? "";
                                    _updConfirmID(stripePayID, confirmID).then((_) {
                                      _showDialog(Colors.green, "付款成功");
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }, onError: (error) {
                                      _showDialog(Colors.red, "調整訂單狀態失敗");
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    });

                                  } else {
                                    _showDialog(Colors.red, "確認預訂車票失敗");
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }

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
  String? _onlineOrdersModelID;
  SearchPriceFillterModel? _searchPriceFilterModel;
  G2railPassengers? _g2railPassenger;

  Future<String> _stripePay() async {

    Reservation reservation = Reservation(
        email: _g2railPassenger!.email!,
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
        ticketConfirmId: _onlineOrdersModelID!,
        PhoneNumber: _g2railPassenger!.phone!,
        PhoneVerified: false,
        currency: "EUR",
        amount: (_searchPriceFilterModel!.price! / 100));

    return await Payment().makeReservation(reservation);
  }

   Future<void> _updConfirmID(String stripePayID, String confirmUrlID) async {
      ReservationRepository reservationRepository = ReservationRepository();
      Reservation reservation = await reservationRepository.fetchReservationByPaymentId(stripePayID);
      reservation.ticketConfirmId = confirmUrlID ?? "";
      return await reservationRepository.updateReservation(reservation.id, reservation);
  }

  Future<ConfrimOrdersModel?> _confirmReservationRailTicket() async {
    var rtn5 = await _client.getConfirmOrders(_onlineOrdersModelID!);
    if(rtn5.isNotEmpty) {
      var rtn6 = await _client.getConfirmAsyncResult(rtn5, retryCounts: 10);
      return rtn6;
    } else {
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