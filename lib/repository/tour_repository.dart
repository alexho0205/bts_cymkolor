import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:bts_cymkolor/models/tour.dart';

class TourRepository {
  Future<List<Tour>> fetchTours({int? limit}) async {
    final jsonString = await rootBundle.loadString('assets/tours.json');
    final jsonResponse = json.decode(jsonString) as List;

    List<Tour> tours = jsonResponse.map((tourJson) => Tour.fromJson(tourJson)).toList();

    if (limit != null && limit > 0 && limit < tours.length) {
      tours = tours.take(limit).toList();
    }

    return tours;
  }
}
