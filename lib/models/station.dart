class Station {
  final String address;
  final String cnName;
  final String enName;
  final String file;
  final double latitude;
  final double longitude;
  final String name;
  final String stationCode;

  Station({
    required this.address,
    required this.cnName,
    required this.enName,
    required this.file,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.stationCode,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      address: json['address'],
      cnName: json['cn_name'],
      enName: json['en_name'],
      file: json['file'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
      stationCode: json['station_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'cn_name': cnName,
      'en_name': enName,
      'file': file,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'station_code': stationCode,
    };
  }
}
