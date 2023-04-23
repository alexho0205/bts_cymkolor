import 'package:flutter/material.dart';

import 'constent.dart';
import 'models/Plan.dart';
import 'order_ticketpage.dart';
import 'repository/plan_repository.dart';

class TravelInfo {
  final String image;
  final String title;
  final String description;
  final String price_info;
  final String currency;
  final int price;

  TravelInfo({required this.image, required this.title, required this.description, required this.price, required this.currency, required this.price_info});
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
      price_info: 'EUR 45',
      price: 45,
      currency: 'EUR',
    ),
     /*TravelInfo(
       image: 'assets/image/travel_1_img.jpg',
       title: '聖米希爾山',
       description: '行程包含南山塔、明洞、樂天世界等知名景點',
       price: 'NTD 40,000',
     ),*/
  ];

  @override
  void initState() {
    super.initState();
    loadPlans();
  }

  void loadPlans() async {
    PlanRepository repository = PlanRepository();
    List<Plan> plans = await repository.getPlans().first;

    plans.forEach((plan) {
      TravelInfo t = TravelInfo(
        image: plan.imageUrl,
        title: plan.title,
        description: plan.description,
        price_info: '${plan.currency} ${(plan.price).toString()}',
        price: plan.price.toInt(),
        currency: plan.currency,
      );
      setState(() {
        travelInfoList.add(t);
      });
    });
  }

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
              travelInfo.image.contains('assets')
                  ? Image.asset(travelInfo.image)
                  : Image.network(travelInfo.image),
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
                  travelInfo.price_info,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  //Navigator.of(context).pushNamed(order_page);

                   Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) {
                     return OrderTicketPage(
                       title: travelInfo.title,
                       price: travelInfo.price,
                       currency: travelInfo.currency,
                     );
                   }));

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

