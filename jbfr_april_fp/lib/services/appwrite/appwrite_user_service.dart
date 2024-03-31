import 'dart:convert';
import 'dart:html';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:jbfr_april_fp/services/user_service.dart';

class AppWriteUserService {
  Client client;
  ValueNotifier<User?> currentUser = ValueNotifier(null);

  static final AppWriteUserService _instance = AppWriteUserService._internal();

  factory AppWriteUserService() {
    return _instance;
  }

  AppWriteUserService._internal()
      : client = Client()
          ..setEndpoint('https://appwrite.alexisl.fr/v1')
          ..setProject('660723c94f4c9e494755')
          ..setSelfSigned(status: true);

  Future<bool> isLogged() async {
    Account account = Account(client);
    UserService();
    try {
      currentUser.value = await account.get();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void login() async {
    Account account = Account(client);
    account.createOAuth2Session(provider: OAuthProvider.discord, success: 'http://localhost:41391/authenticate.html');
  }

  Future<User> getUser() async {
    Account account = Account(client);
    return await account.get();
  }

  Future<List<dynamic>> getAccountLabels() async {
    Account account = Account(client);
    User user = await account.get();
    return user.labels;
  }

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
