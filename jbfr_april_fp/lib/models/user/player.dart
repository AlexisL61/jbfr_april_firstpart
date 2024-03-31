import 'package:jbfr_april_fp/models/file_system/game_folder.dart';

class Player {
  String name;
  String email;

  List<GameFolder> gameFolders = [];

  Player({required this.name, required this.email});

  void updateGameFolders(List<GameFolder> folders) {
    gameFolders = folders;
  }
}
