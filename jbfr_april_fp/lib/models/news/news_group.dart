import 'package:jbfr_april_fp/models/news/news.dart';

class NewsGroup {
  final String name;
  final DateTime date;
  final List<News> news;

  NewsGroup({required this.name, required this.news, required this.date});

  static List<NewsGroup> fromNewsList(List<News> news) {
    List<NewsGroup> newsGroups = [];
    for (var newsItem in news) {
      bool found = false;
      for (var newsGroup in newsGroups) {
        if (newsGroup.date.day == newsItem.date.day &&
            newsGroup.date.month == newsItem.date.month &&
            newsGroup.date.year == newsItem.date.year) {
          newsGroup.news.add(newsItem);
          found = true;
          break;
        }
      }
      if (!found) {
        newsGroups.add(NewsGroup(
            name: newsItem.date.day.toString() +
                "/" +
                newsItem.date.month.toString() +
                "/" +
                newsItem.date.year.toString(),
            news: [newsItem],
            date: newsItem.date));
      }
    }
    return newsGroups;
  }
}
