
class Tour {
  final String id;
  final String name;
  final String intro;
  final String? highlights;
  final double priceEur;
  final List<String> images;
  final String location;

  Tour({
    required this.id,
    required this.name,
    required this.intro,
    required this.highlights,
    required this.priceEur,
    required this.images,
    required this.location,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['_id'],
      name: json['name'],
      intro: json['intro'],
      highlights: json['highlights'],
      priceEur: double.parse(json['price_eur'].toString()),
      images: json['images'] == null ? [] : List<String>.from(json['images']),
      location: json['location'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'intro': intro,
      'highlights': highlights,
      'price_eur': priceEur.toString(),
      'images': images,
      'location': location,
    };
  }

}
