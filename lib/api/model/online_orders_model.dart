class OnlineOrdersModel {
  String? id;
  Railway? railway;
  bool? offlineFulfillment;
  From? from;
  From? to;
  String? trainDescription;
  String? departure;
  String? arrival;
  List<Trains>? trains;
  List<Passengers>? passengers;
  List<Tickets>? tickets;
  String? onlinePaymentUrl;
  Price? ticketPrice;
  Price? paymentPrice;
  Price? chargingPrice;
  Price? rebateAmount;
  List<Records>? records;
  String? memo;

  OnlineOrdersModel(
      {this.id,
      this.railway,
      this.offlineFulfillment,
      this.from,
      this.to,
      this.trainDescription,
      this.departure,
      this.arrival,
      this.trains,
      this.passengers,
      this.tickets,
      this.onlinePaymentUrl,
      this.ticketPrice,
      this.paymentPrice,
      this.chargingPrice,
      this.rebateAmount,
      this.records,
      this.memo});

  OnlineOrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    railway =
        json['railway'] != null ? Railway.fromJson(json['railway']) : null;
    offlineFulfillment = json['offline_fulfillment'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    to = json['to'] != null ? From.fromJson(json['to']) : null;
    trainDescription = json['train_description'];
    departure = json['departure'];
    arrival = json['arrival'];
    if (json['trains'] != null) {
      trains = <Trains>[];
      json['trains'].forEach((v) {
        trains!.add(Trains.fromJson(v));
      });
    }
    if (json['passengers'] != null) {
      passengers = <Passengers>[];
      json['passengers'].forEach((v) {
        passengers!.add(Passengers.fromJson(v));
      });
    }
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(Tickets.fromJson(v));
      });
    }
    onlinePaymentUrl = json['online_payment_url'];
    ticketPrice = json['ticket_price'] != null
        ? Price.fromJson(json['ticket_price'])
        : null;
    paymentPrice = json['payment_price'] != null
        ? Price.fromJson(json['payment_price'])
        : null;
    chargingPrice = json['charging_price'] != null
        ? Price.fromJson(json['charging_price'])
        : null;
    rebateAmount = json['rebate_amount'] != null
        ? Price.fromJson(json['rebate_amount'])
        : null;
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(Records.fromJson(v));
      });
    }
    memo = json['memo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (railway != null) {
      data['railway'] = railway!.toJson();
    }
    data['offline_fulfillment'] = offlineFulfillment;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.toJson();
    }
    data['train_description'] = trainDescription;
    data['departure'] = departure;
    data['arrival'] = arrival;
    if (trains != null) {
      data['trains'] = trains!.map((v) => v.toJson()).toList();
    }
    if (passengers != null) {
      data['passengers'] = passengers!.map((v) => v.toJson()).toList();
    }
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    data['online_payment_url'] = onlinePaymentUrl;
    if (ticketPrice != null) {
      data['ticket_price'] = ticketPrice!.toJson();
    }
    if (paymentPrice != null) {
      data['payment_price'] = paymentPrice!.toJson();
    }
    if (chargingPrice != null) {
      data['charging_price'] = chargingPrice!.toJson();
    }
    if (rebateAmount != null) {
      data['rebate_amount'] = rebateAmount!.toJson();
    }
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    data['memo'] = memo;
    return data;
  }
}

class Railway {
  String? code;

  Railway({this.code});

  Railway.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    return data;
  }
}

class From {
  String? code;
  String? name;
  String? helpUrl;

  From({this.code, this.name, this.helpUrl});

  From.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    helpUrl = json['help_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['name'] = name;
    data['help_url'] = helpUrl;
    return data;
  }
}

class Trains {
  String? number;
  String? type;
  From? from;
  From? to;
  String? departure;
  String? arrival;

  Trains(
      {this.number,
      this.type,
      this.from,
      this.to,
      this.departure,
      this.arrival});

  Trains.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    type = json['type'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    to = json['to'] != null ? From.fromJson(json['to']) : null;
    departure = json['departure'];
    arrival = json['arrival'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['number'] = number;
    data['type'] = type;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.toJson();
    }
    data['departure'] = departure;
    data['arrival'] = arrival;
    return data;
  }
}

class Passengers {
  String? id;
  String? firstName;
  String? lastName;
  String? birthdate;
  String? email;
  String? phone;
  String? gender;

  Passengers(
      {this.id,
      this.firstName,
      this.lastName,
      this.birthdate,
      this.email,
      this.phone,
      this.gender});

  Passengers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    birthdate = json['birthdate'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['birthdate'] = birthdate;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    return data;
  }
}

class Tickets {
  String? id;
  From? from;
  From? to;
  Price? price;

  Tickets({this.id, this.from, this.to, this.price});

  Tickets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    to = json['to'] != null ? From.fromJson(json['to']) : null;
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.toJson();
    }
    if (price != null) {
      data['price'] = price!.toJson();
    }
    return data;
  }
}

class Price {
  String? currency;
  int? cents;

  Price({this.currency, this.cents});

  Price.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    cents = json['cents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currency'] = currency;
    data['cents'] = cents;
    return data;
  }
}

class Records {
  String? id;
  Price? amount;
  String? type;
  String? category;
  String? target;

  Records({this.id, this.amount, this.type, this.category, this.target});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'] != null ? Price.fromJson(json['amount']) : null;
    type = json['type'];
    category = json['category'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (amount != null) {
      data['amount'] = amount!.toJson();
    }
    data['type'] = type;
    data['category'] = category;
    data['target'] = target;
    return data;
  }
}
