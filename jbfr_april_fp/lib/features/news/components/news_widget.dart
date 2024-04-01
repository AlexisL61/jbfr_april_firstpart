import 'package:flutter/material.dart';
import 'package:jbfr_april_fp/dialogs/news_dialog/news_dialog.dart';
import 'package:jbfr_april_fp/models/news/news.dart';
import 'package:jbfr_april_fp/services/appwrite/appwrite_storage_service.dart';

class NewsWidget extends StatefulWidget {
  final News news;
  const NewsWidget({super.key, required this.news});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: () async {
                await showDialog(context: context, builder: (context) => NewsDialog(news: widget.news));
              },
              child: Container(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 400,
                          height: 200,
                          child: FutureBuilder(
                            future: AppWriteStorageService().getFileView(
                              widget.news.image,
                            ), //works for both public file and private file, for private files you need to be logged in
                            builder: (context, snapshot) {
                              return snapshot.hasData && snapshot.data != null
                                  ? Image.memory(
                                      snapshot.data!,
                                    )
                                  : CircularProgressIndicator();
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(widget.news.name, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,)]),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
