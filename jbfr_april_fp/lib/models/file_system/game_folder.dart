import 'package:jbfr_april_fp/models/file_system/game_file.dart';

class GameFolder {
  final String id;
  final String name;
  final List<GameFile> files;
  final bool unlocked;

  GameFolder({required this.id, required this.name, required this.files, required this.unlocked});

  factory GameFolder.fromJson(Map<String, dynamic> json) {
    List<GameFile> files = [];
    for (var file in json['files']) {
      files.add(GameFile.fromJson(file));
    }
    print(json);
    return GameFolder(id: json["\$id"], name: json['title'], files: files, unlocked: json['unlocked']);
  }

  static List<GameFolder> fromJsonList(List<Map<String, dynamic>> list) {
    List<GameFolder> folders = [];
    for (var folder in list) {
      folders.add(GameFolder.fromJson(folder));
    }
    return folders;
  }
}
