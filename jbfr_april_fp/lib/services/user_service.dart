import 'package:appwrite/models.dart';
import 'package:jbfr_april_fp/models/file_system/game_folder.dart';
import 'package:jbfr_april_fp/models/news/news.dart';
import 'package:jbfr_april_fp/models/news/news_group.dart';
import 'package:jbfr_april_fp/models/user/player.dart';
import 'package:jbfr_april_fp/services/appwrite/appwrite_database_service.dart';
import 'package:jbfr_april_fp/services/appwrite/appwrite_user_service.dart';

class UserService {
  Player? player;
  List<NewsGroup> news = [];

  // singleton
  static final UserService _userService = UserService._internal();

  factory UserService() {
    return _userService;
  }

  UserService._internal() {
    AppWriteUserService().currentUser.addListener(updatePlayerFromAppWrite);
  }

  Future<void> updatePlayerFromAppWrite() async {
    User currentUser = await AppWriteUserService().getUser();
    player = Player(email: currentUser.email, name: currentUser.name);
    await updateGameFolders();
    await updateNews();
  }

  Future<void> updateGameFolders() async {
    player?.updateGameFolders(GameFolder.fromJsonList(await AppWriteDatabaseService().retrieveGameFoldersData()));
  }

  Future<void> updateNews() async {
    news = NewsGroup.fromNewsList(News.fromJsonList(await AppWriteDatabaseService().retrieveNewsData()));
  }
}
