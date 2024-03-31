import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

import 'appwrite_user_service.dart';

class AppWriteDatabaseService {
  Client client;
  static final AppWriteDatabaseService _instance = AppWriteDatabaseService._internal();

  factory AppWriteDatabaseService() {
    return _instance;
  }

  AppWriteDatabaseService._internal() : client = AppWriteUserService().client;

  Future<List<Map<String, dynamic>>> retrieveGameFoldersData() async {
    Databases database = Databases(client);
    DocumentList folders = await database.listDocuments(databaseId: "6607527011bc2699afed", collectionId: '6607ef642cbbcc66bb25');
    List<Map<String, dynamic>> foldersData = [];
    folders.documents.forEach((element) {
      foldersData.add(element.data);
    });
    return foldersData;
  }

  Future<List<Map<String, dynamic>>> retrieveNewsData() async {
    Databases database = Databases(client);
    DocumentList news = await database.listDocuments(databaseId: "6607527011bc2699afed", collectionId: '660897c27f3379418403');
    List<Map<String, dynamic>> newsData = [];
    news.documents.forEach((element) {
      newsData.add(element.data);
    });
    return newsData;
  }
}
