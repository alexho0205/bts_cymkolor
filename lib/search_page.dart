import 'package:flutter/material.dart';

import 'constent.dart';
import 'models/Plan.dart';
import 'order_ticketpage.dart';
import 'repository/plan_repository.dart';

class TravelInfo {
  final String image;
  final String title;
  final String description;
  final String price;

  TravelInfo({required this.image, required this.title, required this.description, required this.price});
}

class TravelPage extends StatefulWidget {

  @override
  _TravelPageState createState() {
    return _TravelPageState();
  }
}

class _TravelPageState extends State<TravelPage> {

  final List<TravelInfo> travelInfoList = [
    TravelInfo(
      image: 'assets/image/travel_1_img.jpg',
      title: '新天鵝堡',
      description: '行程包含知名景點',
      price: 'EUR 45',
    ),
    // TravelInfo(
    //   image: 'assets/image/travel_1_img.jpg',
    //   title: '聖米希爾山',
    //   description: '行程包含南山塔、明洞、樂天世界等知名景點',
    //   price: 'NTD 40,000',
    // ),
  ];

  @override
  Widget build(BuildContext context) {

    // todo get solutions
    PlanRepository repository = new PlanRepository();
    Stream<List<Plan>> plans =  repository.getPlans();
    plans.listen((List<Plan> planList) {
      planList.forEach((Plan plan) {
        TravelInfo t = TravelInfo(
          image: 'assets/image/travel_1_img.jpg',
          title: '聖米希爾山',
          description: '行程包含南山塔、明洞、樂天世界等知名景點',
          price: 'NTD 40,000',
        );
        travelInfoList.add(t);
      });
    });
    //travelInfoList.add(  );

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
                  travelInfo.price,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(order_page);

                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return OrderTicketPage();
                  // }));

                  // Navigator.of(context).pop();
                },
                child: const Text('購買'),
              ),
              const SizedBox(height: 20.0),
            ],
          );
        },
      ),
    );
  }
}

