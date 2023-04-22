class Passenger {
  final String lastName;
  final String firstName;
  final String birthdate;
  final String passport;
  final String email;
  final String phone;
  final String gender;

  Passenger({
    required this.lastName,
    required this.firstName,
    required this.birthdate,
    required this.passport,
    required this.email,
    required this.phone,
    required this.gender,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      lastName: json['last_name'],
      firstName: json['first_name'],
      birthdate: json['birthdate'],
      passport: json['passport'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_name': lastName,
      'first_name': firstName,
      'birthdate': birthdate,
      'passport': passport,
      'email': email,
      'phone': phone,
      'gender': gender,
    };
  }
}
