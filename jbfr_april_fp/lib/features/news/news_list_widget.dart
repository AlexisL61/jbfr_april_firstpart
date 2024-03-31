import 'package:flutter/material.dart';
import 'package:jbfr_april_fp/dialogs/unlock_dialog/unlock_dialog.dart';
import 'package:jbfr_april_fp/features/news/components/news_widget.dart';
import 'package:jbfr_april_fp/features/usb_key/components/file_widget.dart';
import 'package:jbfr_april_fp/features/usb_key/usb_key_controller.dart';
import 'package:jbfr_april_fp/models/news/news_group.dart';
import 'package:jbfr_april_fp/services/user_service.dart';

class NewsListWidget extends StatefulWidget {
  const NewsListWidget({super.key});

  @override
  State<NewsListWidget> createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  int selectedNewsList = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildNewsListTab(),
        Expanded(child: _buildFiles()),
      ],
    );
  }

  Widget _buildNewsListTab() {
    List<NewsGroup> newsGroups = UserService().news;
    return Container(
        color: Theme.of(context).colorScheme.shadow,
        child: Column(
            children: List.generate(
                newsGroups.length,
                (index) => InkWell(
                      onTap: () async {
                        setState(() {
                          selectedNewsList = index;
                        });
                      },
                      child: Container(
                          width: 160,
                          color: index == selectedNewsList ? Colors.blue : Colors.transparent,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(newsGroups[index].name),
                                ],
                              ))),
                    ))));
  }

  Widget _buildFiles() {
    return GridView.count(
      crossAxisCount: (MediaQuery.of(context).size.width - 220) ~/ 450,
      childAspectRatio: 1,
      children: List.generate(UserService().news[selectedNewsList].news.length,
          (index) => NewsWidget(news: UserService().news[selectedNewsList].news[index])),
    );
  }
}
