class News {
  final String? author;
  final String? title;
  final String? description;
  final String? image;
  final String? category;
  final String? country;
  final DateTime? publishedAt;

  News({
    this.author,
    this.title,
    this.description,
    this.image,
    this.category,
    this.country,
    this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json['author'],
      description: json['description'],
      image: json['image'],
      title: json['title'],
      category: json['category'],
      country: json['country'].toString().toUpperCase(),
      publishedAt: DateTime.parse(json['published_at']),
    );
  }
}
