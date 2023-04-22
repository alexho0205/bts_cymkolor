import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bts_cymkolor/api/model/search_ticket_model.dart';

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

  Future<List<AsyncResult>> getAsyncResult(String asyncKey,
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
        List<AsyncResult> result = [];
        for (int i = 0; i < (json as List).length; i++) {
          result.add(AsyncResult.fromJson((json as List)[i]));
        }
        return result;
      }
    }
    // try {
    //   if (rtn["code"] != null && rtn["code"] == "async_not_ready") {
    // await Future.delayed(const Duration(seconds: 5), () {
    //   //秒數可以依需求修改
    //   return getAsyncResult(asyncKey, retryCounts: retryCounts -= 1);
    // });
    //   } else {
    //     return jsonDecode(utf8.decode(asyncResult.bodyBytes));
    //   }
    // } catch (ex) {
    //   //print(rtn[1]);
    //   //final search = SearchTicketModel.fromJson(rtn[1]);
    //   //return search;
    // }
  }
}
