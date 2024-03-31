import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jbfr_april_fp/models/news/news.dart';
import 'package:jbfr_april_fp/services/appwrite/appwrite_storage_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsDialog extends StatefulWidget {
  final News news;
  const NewsDialog({super.key, required this.news});

  @override
  State<NewsDialog> createState() => _NewsDialogState();
}

class _NewsDialogState extends State<NewsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.news.name),
        content: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                future: AppWriteStorageService().getFileView(
                  widget.news.image,
                ), //works for both public file and private file, for private files you need to be logged in
                builder: (context, snapshot) {
                  return snapshot.hasData && snapshot.data != null
                      ? Image.memory(
                          snapshot.data!,
                          width: 300,
                        )
                      : CircularProgressIndicator();
                },
              ),
              MarkdownBody(
                data: widget.news.description,
                onTapLink: (text, href, title) {
                  launchUrlString(href!);
                },
              )
            ],
          ),
        ));
  }
}
