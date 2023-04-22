class ConfrimOrdersModel {
  String? id;
  Order? order;
  Price? ticketPrice;
  Price? paymentPrice;
  Price? rtpPrice;
  Price? chargingPrice;
  Price? rebateAmount;
  List<Records>? records;
  String? confirmAgain;

  ConfrimOrdersModel(
      {this.id,
      this.order,
      this.ticketPrice,
      this.paymentPrice,
      this.rtpPrice,
      this.chargingPrice,
      this.rebateAmount,
      this.records,
      this.confirmAgain});

  ConfrimOrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    ticketPrice = json['ticket_price'] != null
        ? Price.fromJson(json['ticket_price'])
        : null;
    paymentPrice = json['payment_price'] != null
        ? Price.fromJson(json['payment_price'])
        : null;
    rtpPrice =
        json['rtp_price'] != null ? Price.fromJson(json['rtp_price']) : null;
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
    confirmAgain = json['confirm_again'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (ticketPrice != null) {
      data['ticket_price'] = ticketPrice!.toJson();
    }
    if (paymentPrice != null) {
      data['payment_price'] = paymentPrice!.toJson();
    }
    if (rtpPrice != null) {
      data['rtp_price'] = rtpPrice!.toJson();
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
    data['confirm_again'] = confirmAgain;
    return data;
  }
}

class Order {
  String? id;
  String? pNR;
  Railway? railway;
  From? from;
  From? to;
  String? departure;
  List<Passengers>? passengers;
  List<Tickets>? tickets;
  String? memo;

  Order(
      {this.id,
      this.pNR,
      this.railway,
      this.from,
      this.to,
      this.departure,
      this.passengers,
      this.tickets,
      this.memo});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pNR = json['PNR'];
    railway =
        json['railway'] != null ? Railway.fromJson(json['railway']) : null;
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    to = json['to'] != null ? From.fromJson(json['to']) : null;
    departure = json['departure'];
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
    memo = json['memo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['PNR'] = pNR;
    if (railway != null) {
      data['railway'] = railway!.toJson();
    }
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.toJson();
    }
    data['departure'] = departure;
    if (passengers != null) {
      data['passengers'] = passengers!.map((v) => v.toJson()).toList();
    }
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
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

  From({this.code, this.name});

  From.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['name'] = name;
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
