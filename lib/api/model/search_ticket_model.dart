class AsyncResult {
  Railway? railway;
  bool? loading;
  List<Solutions>? solutions;

  AsyncResult({this.railway, this.loading, this.solutions});

  AsyncResult.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to!.toJson();
    }
    data['departure'] = this.departure;
    if (this.duration != null) {
      data['duration'] = this.duration!.toJson();
    }
    data['transfer_times'] = this.transferTimes;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['help_url'] = this.helpUrl;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['hour'] = this.hour;
    data['minutes'] = this.minutes;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['carrier_code'] = this.carrierCode;
    data['carrier_description'] = this.carrierDescription;
    data['carrier_icon'] = this.carrierIcon;
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    if (this.trains != null) {
      data['trains'] = this.trains!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offers {
  String? code;
  String? description;
  String? detail;
  String? helpUrl;
  Null? restriction;
  Null? ticketType;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    data['detail'] = this.detail;
    data['help_url'] = this.helpUrl;
    data['restriction'] = this.restriction;
    data['ticket_type'] = this.ticketType;
    data['seat_type'] = this.seatType;
    data['refund_type'] = this.refundType;
    data['confirm_again'] = this.confirmAgain;
    data['change_type'] = this.changeType;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String? code;
  String? description;
  String? detail;
  Null? featurePhoto;
  Available? available;
  Price? price;
  Price? averageUnitPrice;
  String? bookingCode;
  String? bookingType;
  Null? hasWifi;
  Null? hasPowerOutlet;
  Null? hasAirConditioning;
  Null? hasEntertainmentSystem;
  Null? hasReadingLight;
  Null? seatReservation;
  Null? seatType;
  Null? numberOfSeatsPerRow;
  Null? bedType;
  Null? toiletType;
  Null? foodServiceType;
  Null? foodDrinks;
  Null? freeMegazine;
  Null? cleaningKit;
  Null? welcomeKit;
  Null? loungeService;
  Null? checkIn;
  Null? silentArea;
  Null? privateCabin;
  Null? playArea;
  Null? bicycleSpace;
  Null? disabledFacilities;
  Null? morningCall;
  String? helpUrl;

  Services(
      {this.code,
      this.description,
      this.detail,
      this.featurePhoto,
      this.available,
      this.price,
      this.averageUnitPrice,
      this.bookingCode,
      this.bookingType,
      this.hasWifi,
      this.hasPowerOutlet,
      this.hasAirConditioning,
      this.hasEntertainmentSystem,
      this.hasReadingLight,
      this.seatReservation,
      this.seatType,
      this.numberOfSeatsPerRow,
      this.bedType,
      this.toiletType,
      this.foodServiceType,
      this.foodDrinks,
      this.freeMegazine,
      this.cleaningKit,
      this.welcomeKit,
      this.loungeService,
      this.checkIn,
      this.silentArea,
      this.privateCabin,
      this.playArea,
      this.bicycleSpace,
      this.disabledFacilities,
      this.morningCall,
      this.helpUrl});

  Services.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    detail = json['detail'];
    featurePhoto = json['feature_photo'];
    available = json['available'] != null
        ? Available.fromJson(json['available'])
        : null;
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    averageUnitPrice = json['average_unit_price'] != null
        ? Price.fromJson(json['average_unit_price'])
        : null;
    bookingCode = json['booking_code'];
    bookingType = json['booking_type'];
    hasWifi = json['has_wifi'];
    hasPowerOutlet = json['has_power_outlet'];
    hasAirConditioning = json['has_air_conditioning'];
    hasEntertainmentSystem = json['has_entertainment_system'];
    hasReadingLight = json['has_reading_light'];
    seatReservation = json['seat_reservation'];
    seatType = json['seat_type'];
    numberOfSeatsPerRow = json['number_of_seats_per_row'];
    bedType = json['bed_type'];
    toiletType = json['toilet_type'];
    foodServiceType = json['food_service_type'];
    foodDrinks = json['food_drinks'];
    freeMegazine = json['free_megazine'];
    cleaningKit = json['cleaning_kit'];
    welcomeKit = json['welcome_kit'];
    loungeService = json['lounge_service'];
    checkIn = json['check_in'];
    silentArea = json['silent_area'];
    privateCabin = json['private_cabin'];
    playArea = json['play_area'];
    bicycleSpace = json['bicycle_space'];
    disabledFacilities = json['disabled_facilities'];
    morningCall = json['morning_call'];
    helpUrl = json['help_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    data['detail'] = this.detail;
    data['feature_photo'] = this.featurePhoto;
    if (this.available != null) {
      data['available'] = this.available!.toJson();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.averageUnitPrice != null) {
      data['average_unit_price'] = this.averageUnitPrice!.toJson();
    }
    data['booking_code'] = this.bookingCode;
    data['booking_type'] = this.bookingType;
    data['has_wifi'] = this.hasWifi;
    data['has_power_outlet'] = this.hasPowerOutlet;
    data['has_air_conditioning'] = this.hasAirConditioning;
    data['has_entertainment_system'] = this.hasEntertainmentSystem;
    data['has_reading_light'] = this.hasReadingLight;
    data['seat_reservation'] = this.seatReservation;
    data['seat_type'] = this.seatType;
    data['number_of_seats_per_row'] = this.numberOfSeatsPerRow;
    data['bed_type'] = this.bedType;
    data['toilet_type'] = this.toiletType;
    data['food_service_type'] = this.foodServiceType;
    data['food_drinks'] = this.foodDrinks;
    data['free_megazine'] = this.freeMegazine;
    data['cleaning_kit'] = this.cleaningKit;
    data['welcome_kit'] = this.welcomeKit;
    data['lounge_service'] = this.loungeService;
    data['check_in'] = this.checkIn;
    data['silent_area'] = this.silentArea;
    data['private_cabin'] = this.privateCabin;
    data['play_area'] = this.playArea;
    data['bicycle_space'] = this.bicycleSpace;
    data['disabled_facilities'] = this.disabledFacilities;
    data['morning_call'] = this.morningCall;
    data['help_url'] = this.helpUrl;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['seats'] = this.seats;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['currency'] = this.currency;
    data['cents'] = this.cents;
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
  Null? stops;

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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['number'] = this.number;
    data['type'] = this.type;
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to!.toJson();
    }
    data['departure'] = this.departure;
    data['arrival'] = this.arrival;
    data['help_url'] = this.helpUrl;
    data['stops'] = this.stops;
    return data;
  }
}
