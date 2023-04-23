
import 'dart:ffi';

import 'package:flutter/material.dart';

import 'constent.dart';

class TravelSetInfo {
  final String image;
  final String title;
  final String description;
  final String description2;

  TravelSetInfo({required this.image, required this.title, required this.description, required this.description2});
}

class TravelSetPage extends StatefulWidget {

  @override
  _TravelSetPageState createState() {
    return _TravelSetPageState();
  }
}

class _TravelSetPageState extends State<TravelSetPage> {

  final List<TravelSetInfo> travelInfoList = [
    TravelSetInfo(
      image: 'assets/image/travel_set_1_img.jpg',
      title: '新天鵝堡一日套票',
      description: '最優惠的行程',
      description2: '鐵路+門票',
    ),
    TravelSetInfo(
      image: 'assets/image/travel_set_2_img.jpg',
      title: '聖米歇爾山一日套票',
      description: '最優惠的行程',
      description2: '鐵路+門票',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: travelInfoList.length,
        itemBuilder: (context, index) {
          final travelInfo = travelInfoList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(travelInfo.image),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  travelInfo.title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(travelInfo.description),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  travelInfo.description2,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(order_set_page);
                },
                child: const Text('查詢'),
              ),
              const SizedBox(height: 20.0),
            ],
          );
        },
      ),
    );
  }
}
