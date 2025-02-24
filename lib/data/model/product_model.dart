class ProductModel {
  final int id;
  final String? title; // Nullable
  final double price;
  final String? description; // Nullable
  final String? category; // Nullable
  final String? image; // Nullable
  final Rating rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0, // Fallback for id (though unlikely null)
      title: json['title'] ?? 'Unknown Title',
      price: (json['price'] ?? 0).toDouble(), // Fallback for price
      description: json['description'] ?? 'No description',
      category: json['category'] ?? 'Uncategorized',
      image: json['image'] ?? '',
      rating: Rating.fromJson(json['rating'] ?? {'rate': 0.0, 'count': 0}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] ?? 0).toDouble(),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}