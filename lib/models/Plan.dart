class Plan {
  final String id;
  final String title;
  final String description;
  final String currency;
  final double price;
  final String imageUrl;
  final String country;

  Plan({
    required this.id,
    required this.title,
    required this.description,
    required this.currency,
    required this.price,
    required this.imageUrl,
    required this.country,
  });

  Plan.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        description = data['description'],
        currency = data['currency'],
        price = data['price'].toDouble(),
        imageUrl = data['imageUrl'],
        country = data['country'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'currency': currency,
      'price': price,
      'imageUrl': imageUrl,
      'country': country,
    };
  }
}
