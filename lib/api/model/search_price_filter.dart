import 'package:bts_cymkolor/api/model/search_ticket_model.dart';
class SearchPriceFillterModel {
  String? bookingcode;
  int? price;
  String? departure; //發車時間
  String? arrival; //到站時間(先不要理)
  Dur? duration; //時常

  SearchPriceFillterModel(
      {this.bookingcode,
        this.price,
        this.departure,
        this.arrival,
        this.duration});

  SearchPriceFillterModel.fromJson(Map<String, dynamic> json) {
    bookingcode = json['bookingcode'];
    price = json['price'];
    departure = json['departure'];
    arrival = json['arrival'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['bookingcode'] = bookingcode;
    data['price'] = price;
    data['departure'] = departure;
    data['arrival'] = arrival;
    data['duration'] = duration;
    return data;
  }
}
