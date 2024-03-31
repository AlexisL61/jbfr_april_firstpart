import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:jbfr_april_fp/services/appwrite/appwrite_user_service.dart';

class AppWriteFunctionService {
  Client client;
  static final AppWriteFunctionService _instance = AppWriteFunctionService._internal();

  factory AppWriteFunctionService() {
    return _instance;
  }

  AppWriteFunctionService._internal() : client = AppWriteUserService().client;

  Future<bool> tryPassword(String password, String folder) async {
    Functions functions = Functions(client);
    Execution result = await functions.createExecution(
      functionId: '66081225e0a702e52fc2',
      body: jsonEncode({
        'password': password,
        'part': folder,
      }),
    );

    Map<String, dynamic> data = jsonDecode(result.responseBody);
    if (data['error'] != null) {
      return false;
    }
    return true;
  }
}
