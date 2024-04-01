import 'package:jbfr_april_fp/services/user_service.dart';

class HomeController {
  Future<void> retrieveData() async {
    await UserService().updatePlayerFromAppWrite();
  }
}