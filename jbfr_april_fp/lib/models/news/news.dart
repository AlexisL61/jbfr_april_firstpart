class News {
  final DateTime date;
  final String name;
  final String image;
  final String description;

  News({required this.date, required this.name, required this.image, required this.description});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(date: DateTime.parse(json['date']), name: json['name'], image: json['image'], description: json['description']);
  }

  static List<News> fromJsonList(List<Map<String, dynamic>> list) {
    List<News> news = [];
    for (var newsItem in list) {
      news.add(News.fromJson(newsItem));
    }
    return news;
  }
}
