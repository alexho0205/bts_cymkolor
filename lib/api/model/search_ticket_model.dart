class SearchTicketModel {
  Railway? railway;
  bool? loading;
  List<Solutions>? solutions;

  SearchTicketModel({this.railway, this.loading, this.solutions});

  SearchTicketModel.fromJson(Map<String, dynamic> json) {
    railway =
    json['railway'] != null ? Railway.fromJson(json['railway']) : null;
    loading = json['loading'];
    if (json['solutions'] != null) {
      solutions = <Solutions>[];
      json['solutions'].forEach((v) {
        solutions!.add(Solutions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (railway != null) {
      data['railway'] = railway!.toJson();
    }
    data['loading'] = loading;
    if (solutions != null) {
      data['solutions'] = solutions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Railway {
  String? code;

  Railway({code});

  Railway.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    return data;
  }
}

class Solution {
  List<Solutions>? solutions;

  Solution({solutions});

  Solution.fromJson(Map<String, dynamic> json) {
    if (json['solutions'] != null) {
      solutions = <Solutions>[];
      json['solutions'].forEach((v) {
        solutions!.add(Solutions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (solutions != null) {
      data['solutions'] = solutions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Solutions {
  From? from;
  From? to;
  String? departure;
  Dur? duration;
  int? transferTimes;
  List<Sections>? sections;

  Solutions(
      {this.from,
        this.to,
        this.departure,
        this.duration,
        this.transferTimes,
        this.sections});

  Solutions.fromJson(Map<String, dynamic> json) {
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    to = json['to'] != null ? From.fromJson(json['to']) : null;
    departure = json['departure'];
    duration = json['duration'] != null ? Dur.fromJson(json['duration']) : null;
    transferTimes = json['transfer_times'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.toJson();
    }
    data['departure'] = departure;
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    data['transfer_times'] = transferTimes;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
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

class Dur {
  int? hour;
  int? minutes;

  Dur({this.hour, this.minutes});

  Dur.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['hour'] = hour;
    data['minutes'] = minutes;
    return data;
  }
}

class Sections {
  String? carrierCode;
  String? carrierDescription;
  String? carrierIcon;
  List<Offers>? offers;
  List<Trains>? trains;

  Sections(
      {this.carrierCode,
        this.carrierDescription,
        this.carrierIcon,
        this.offers,
        this.trains});

  Sections.fromJson(Map<String, dynamic> json) {
    carrierCode = json['carrier_code'];
    carrierDescription = json['carrier_description'];
    carrierIcon = json['carrier_icon'];
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(Offers.fromJson(v));
      });
    }
    if (json['trains'] != null) {
      trains = <Trains>[];
      json['trains'].forEach((v) {
        trains!.add(Trains.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['carrier_code'] = carrierCode;
    data['carrier_description'] = carrierDescription;
    data['carrier_icon'] = carrierIcon;
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    if (trains != null) {
      data['trains'] = trains!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offers {
  String? code;
  String? description;
  String? detail;
  String? helpUrl;
  Restriction? restriction;
  String? ticketType;
  String? seatType;
  String? refundType;
  String? confirmAgain;
  String? changeType;
  List<Services>? services;

  Offers(
      {this.code,
        this.description,
        this.detail,
        this.helpUrl,
        this.restriction,
        this.ticketType,
        this.seatType,
        this.refundType,
        this.confirmAgain,
        this.changeType,
        this.services});

  Offers.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    detail = json['detail'];
    helpUrl = json['help_url'];
    restriction = json['restriction'];
    ticketType = json['ticket_type'];
    seatType = json['seat_type'];
    refundType = json['refund_type'];
    confirmAgain = json['confirm_again'];
    changeType = json['change_type'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['description'] = description;
    data['detail'] = detail;
    data['help_url'] = helpUrl;
    data['restriction'] = restriction;
    data['ticket_type'] = ticketType;
    data['seat_type'] = seatType;
    data['refund_type'] = refundType;
    data['confirm_again'] = confirmAgain;
    data['change_type'] = changeType;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restriction {
  String? code;
  String? description;
  String? detail;

  Restriction({this.code, this.description, this.detail});

  Restriction.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['description'] = description;
    data['detail'] = detail;
    return data;
  }
}

class Services {
  String? code;
  String? description;
  String? detail;
  Available? available;
  AverageUnitPrice? averageUnitPrice;
  AverageUnitPrice? price;
  String? bookingCode;
  String? bookingType;

  Services(
      {this.code,
        this.description,
        this.detail,
        this.available,
        this.averageUnitPrice,
        this.price,
        this.bookingCode,
        this.bookingType});

  Services.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    detail = json['detail'];
    available = json['available'] != null
        ? Available.fromJson(json['available'])
        : null;
    averageUnitPrice = json['average_unit_price'] != null
        ? AverageUnitPrice.fromJson(json['average_unit_price'])
        : null;
    price =
    json['price'] != null ? AverageUnitPrice.fromJson(json['price']) : null;
    bookingCode = json['booking_code'];
    bookingType = json['booking_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['description'] = description;
    data['detail'] = detail;
    if (available != null) {
      data['available'] = available!.toJson();
    }
    if (averageUnitPrice != null) {
      data['average_unit_price'] = averageUnitPrice!.toJson();
    }
    if (price != null) {
      data['price'] = price!.toJson();
    }
    data['booking_code'] = bookingCode;
    data['booking_type'] = bookingType;
    return data;
  }
}

class AverageUnitPrice {
  String? currency;
  int? cents;

  AverageUnitPrice({this.currency, this.cents});

  AverageUnitPrice.fromJson(Map<String, dynamic> json) {
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

class Available {
  int? seats;

  Available({this.seats});

  Available.fromJson(Map<String, dynamic> json) {
    seats = json['seats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['seats'] = seats;
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

class Trains {
  String? number;
  String? type;
  From? from;
  From? to;
  String? departure;
  String? arrival;
  String? helpUrl;
  Stops? stops;

  Trains(
      {this.number,
        this.type,
        this.from,
        this.to,
        this.departure,
        this.arrival,
        this.helpUrl,
        this.stops});

  Trains.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    type = json['type'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    to = json['to'] != null ? From.fromJson(json['to']) : null;
    departure = json['departure'];
    arrival = json['arrival'];
    helpUrl = json['help_url'];
    stops = json['stops'];
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
    data['help_url'] = helpUrl;
    data['stops'] = stops;
    return data;
  }
}

class Stops {
  String? code;
  String? name;
  String? helpurl;

  Stops({this.code, this.name, this.helpurl});

  Stops.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    helpurl = json['help_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['name'] = name;
    data['help_url'] = helpurl;
    return data;
  }
}
