import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:jbfr_april_fp/services/appwrite/appwrite_user_service.dart';

class AppWriteStorageService {
  Client client;
  static final AppWriteStorageService _instance = AppWriteStorageService._internal();

  factory AppWriteStorageService() {
    return _instance;
  }

  AppWriteStorageService._internal() : client = AppWriteUserService().client;

  Future<dynamic> getFilePreview(String fileId) async {
    Storage storage = Storage(client);
    return await storage.getFilePreview(fileId: fileId, bucketId: '66075316c55f6a6a3589', width: 200);
  }

  Future<Uint8List> getFileView(String fileId) async {
    Storage storage = Storage(client);
    return await storage.getFileView(fileId: fileId, bucketId: '66075316c55f6a6a3589');
  }
}
