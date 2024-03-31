import 'package:flutter/material.dart';
import 'package:jbfr_april_fp/models/file_system/game_file.dart';
import 'package:jbfr_april_fp/services/appwrite/appwrite_storage_service.dart';
import 'package:url_launcher/url_launcher.dart';

class FileWidget extends StatefulWidget {
  final GameFile file;
  const FileWidget({super.key, required this.file});

  @override
  State<FileWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
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
              onTap: () {
                launchUrl(
                    Uri.parse("https://appwrite.alexisl.fr/v1/storage/buckets/66075316c55f6a6a3589/files/${widget.file.url}/download?project=660723c94f4c9e494755"));
              },
              child: Container(
                height: 300,
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: FutureBuilder(
                            future: AppWriteStorageService().getFilePreview(
                              widget.file.url,
                            ), //works for both public file and private file, for private files you need to be logged in
                            builder: (context, snapshot) {
                              return snapshot.hasData && snapshot.data != null
                                  ? Image.memory(
                                      snapshot.data,
                                    )
                                  : CircularProgressIndicator();
                            },
                          ),
                        ),
                        Text(widget.file.name),
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
