import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bts_cymkolor/api/model/search_ticket_model.dart';
import 'package:bts_cymkolor/api/model/online_orders_model.dart';
import 'package:bts_cymkolor/api/model/confrim_order_model.dart';
import 'package:bts_cymkolor/api/model/download_ticket_model.dart';

class SearchCriteria {
  String from;
  String to;
  String date;
  String time;
  int adult;
  int child;

  SearchCriteria(
      this.from, this.to, this.date, this.time, this.adult, this.child);

  String toQuery() {
    return "from=$from&to=$to&date=$date&time=$time&adult=$adult&child=$child";
  }

  Map<String, dynamic> toMap() {
    return {
      "from": from,
      "to": to,
      "date": date,
      "time": time,
      "adult": adult,
      "child": child
    };
  }
}

class Passengers {
  String? lastName;
  String? firstName;
  String? birthdate;
  String? passport;
  String? email;
  String? phone;
  String? gender;

  Passengers(
      {this.lastName,
      this.firstName,
      this.birthdate,
      this.passport,
      this.email,
      this.phone,
      this.gender});

  Passengers.fromJson(Map<String, dynamic> json) {
    lastName = json['last_name'];
    firstName = json['first_name'];
    birthdate = json['birthdate'];
    passport = json['passport'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['birthdate'] = birthdate;
    data['passport'] = passport;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    return data;
  }
}

class OnlineOrders {
  List<Passengers> passeners;
  List<String> sections;
  bool seatReserved;
  String memo;

  OnlineOrders(this.passeners, this.sections, this.seatReserved, this.memo);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (passeners != null) {
      data['passengers'] = passeners!.map((v) => v.toJson()).toList();
    }
    data['sections'] = sections;
    data['seat_reserved'] = seatReserved;
    data['memo'] = memo;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "passengers": passeners,
      "to": sections,
      "seat_reserved": seatReserved,
      "memo": memo
    };
  }
}

class Confirm {
  String online_order_id;

  Confirm(this.online_order_id);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['online_order_id'] = online_order_id;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {"online_order_id": online_order_id};
  }
}

class GrailApiClient {
  final baseUrl;
  final apiKey;
  final secret;
  final http.Client httpClient;

  GrailApiClient(
      {required this.httpClient,
      @required this.baseUrl,
      @required this.apiKey,
      @required this.secret})
      : assert(httpClient != null);

  Map<String, String> getAuthorizationHeaders(Map<String, dynamic> params) {
    var timestamp = DateTime.now();
    params['t'] = (timestamp.millisecondsSinceEpoch ~/ 1000).toString();
    params['api_key'] = apiKey;

    var sortedKeys = params.keys.toList()..sort((a, b) => a.compareTo(b));
    StringBuffer buffer = StringBuffer("");
    sortedKeys.forEach((key) {
      if (params[key] is List || params[key] is Map) return;
      buffer.write('$key=${params[key].toString()}');
    });
    buffer.write(secret);

    String hashString = buffer.toString();
    String authorization = md5.convert(utf8.encode(hashString)).toString();

    return {
      "From": apiKey,
      "Content-Type": 'application/json',
      "Authorization": authorization,
      "Date": HttpDate.format(timestamp),
      "Api-Locale": "zh-TW"
    };
  }

  Future<String> getSolutions(from, to, date, time, adult, child) async {
    final criteria = SearchCriteria(from, to, date, time, adult, child);
    final solutionUrl =
        '$baseUrl/api/v2/online_solutions/?${criteria.toQuery()}';

    final solutionResponse = await httpClient.get(Uri.parse(solutionUrl),
        headers: getAuthorizationHeaders(criteria.toMap()));

    if (solutionResponse.statusCode != 200) {
      throw Exception('error getting solutions');
    }

    final solutionsJson = jsonDecode(solutionResponse.body);
    print(solutionResponse.body);
    return solutionsJson["async"];
  }

  Future<List<SearchTicketModel?>> getAsyncResult(String asyncKey,
      {int retryCounts = 3}) async {
    if (retryCounts == 0) {
      return [];
    }
    final asyncResultURl = '$baseUrl/api/v2/async_results/$asyncKey';
    final asyncResult = await httpClient.get(Uri.parse(asyncResultURl),
        headers: getAuthorizationHeaders({"async_key": asyncKey}));

    print("retryCnt: $retryCounts : ${utf8.decode(asyncResult.bodyBytes)}");
    var json = jsonDecode(utf8.decode(asyncResult.bodyBytes));

    if (json.toString().contains("async_not_ready")) {
      return await Future.delayed(const Duration(seconds: 5), () {
        //秒數可以依需求修改
        return getAsyncResult(asyncKey, retryCounts: retryCounts -= 1);
      });
    } else {
      if (json.toString().contains("async_not_ready")) {
        return [];
      } else {
        List<SearchTicketModel> result = [];
        for (int i = 0; i < (json as List).length; i++) {
          result.add(SearchTicketModel.fromJson((json as List)[i]));
        }
        return result;
      }
    }
  }

  Future<String> getOnlineOrders(
      passengers, sections, seatReserved, memo) async {
    final onlineorder = OnlineOrders(passengers, sections, seatReserved, memo);
    final solutionUrl = '$baseUrl/api/v2/online_orders';

    final solutionResponse = await httpClient.post(Uri.parse(solutionUrl),
        headers: getAuthorizationHeaders(onlineorder.toMap()),
        body: jsonEncode(onlineorder.toJson()));

    final solutionsJson = jsonDecode(solutionResponse.body);
    print(solutionResponse.body);
    return solutionsJson["async"];
  }

  Future<OnlineOrdersModel?> getOrdersAsyncResult(String asyncKey,
      {int retryCounts = 3}) async {
    if (retryCounts == 0) {
      return null;
    }
    try {
      final asyncResultURl = '$baseUrl/api/v2/async_results/$asyncKey';
      final asyncResult = await httpClient.get(Uri.parse(asyncResultURl),
          headers: getAuthorizationHeaders({"async_key": asyncKey}));

      print("retryCnt: $retryCounts : ${utf8.decode(asyncResult.bodyBytes)}");
      var json = jsonDecode(utf8.decode(asyncResult.bodyBytes));

      if (json.toString().contains("async_not_ready")) {
        return await Future.delayed(const Duration(seconds: 5), () {
          //秒數可以依需求修改
          return getOrdersAsyncResult(asyncKey, retryCounts: retryCounts -= 1);
        });
      } else {
        if (json.toString().contains("async_not_ready")) {
          return null;
        } else {
          OnlineOrdersModel result = OnlineOrdersModel.fromJson(json);
          return result;
        }
      }
    } catch (ex) {
      return await Future.delayed(const Duration(seconds: 5), () {
        //秒數可以依需求修改
        return getOrdersAsyncResult(asyncKey, retryCounts: retryCounts -= 1);
      });
    }
  }

  Future<String> getConfirmOrders(String onlineorderid) async {
    final onlineorder = Confirm(onlineorderid);
    final solutionUrl =
        '$baseUrl/api/v2/online_orders/${onlineorderid}/online_confirmations';

    final solutionResponse = await httpClient.post(Uri.parse(solutionUrl),
        headers: getAuthorizationHeaders(onlineorder.toMap()),
        body: jsonEncode(onlineorder.toJson()));

    final solutionsJson = jsonDecode(solutionResponse.body);
    print(solutionResponse.body);
    return solutionsJson["async"];
  }

  Future<ConfrimOrdersModel?> getConfirmAsyncResult(String asyncKey,
      {int retryCounts = 3}) async {
    if (retryCounts == 0) {
      return null;
    }
    try {
      final asyncResultURl = '$baseUrl/api/v2/async_results/$asyncKey';
      final asyncResult = await httpClient.get(Uri.parse(asyncResultURl),
          headers: getAuthorizationHeaders({"async_key": asyncKey}));

      print("retryCnt: $retryCounts : ${utf8.decode(asyncResult.bodyBytes)}");
      var json = jsonDecode(utf8.decode(asyncResult.bodyBytes));

      if (json.toString().contains("async_not_ready")) {
        return await Future.delayed(const Duration(seconds: 5), () {
          //秒數可以依需求修改
          return getConfirmAsyncResult(asyncKey, retryCounts: retryCounts -= 1);
        });
      } else {
        if (json.toString().contains("async_not_ready")) {
          return null;
        } else {
          ConfrimOrdersModel result = ConfrimOrdersModel.fromJson(json);
          return result;
        }
      }
    } catch (ex) {
      return await Future.delayed(const Duration(seconds: 5), () {
        //秒數可以依需求修改
        return getConfirmAsyncResult(asyncKey, retryCounts: retryCounts -= 1);
      });
    }
  }

  Future<List<DownLoadTicketModel?>> getDownLoadTicketAsyncResult(
      String online_order_id,
      {int retryCounts = 3}) async {
    if (retryCounts == 0) {
      return [];
    }
    final asyncResultURl =
        '$baseUrl/api/v2/online_orders/$online_order_id/online_tickets';
    final asyncResult = await httpClient.get(Uri.parse(asyncResultURl),
        headers: getAuthorizationHeaders({"online_order_id": online_order_id}));

    print("retryCnt: $retryCounts : ${utf8.decode(asyncResult.bodyBytes)}");
    var json = jsonDecode(utf8.decode(asyncResult.bodyBytes));

    if (json.toString().contains("async_not_ready")) {
      return await Future.delayed(const Duration(seconds: 5), () {
        //秒數可以依需求修改
        return getDownLoadTicketAsyncResult(online_order_id,
            retryCounts: retryCounts -= 1);
      });
    } else {
      if (json.toString().contains("async_not_ready")) {
        return [];
      } else {
        List<DownLoadTicketModel> result = [];
        for (int i = 0; i < (json as List).length; i++) {
          result.add(DownLoadTicketModel.fromJson((json as List)[i]));
        }
        return result;
      }
    }
  }
}
