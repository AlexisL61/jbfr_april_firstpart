import 'package:jbfr_april_fp/features/login/login_model.dart';
import 'package:jbfr_april_fp/services/appwrite/appwrite_user_service.dart';
import 'package:jbfr_april_fp/services/user_service.dart';

class LoginController {
  Future<LoginStatus> verifyConnection() async {
    bool isLogged = await AppWriteUserService().isLogged();
    if (isLogged)
    await UserService().updatePlayerFromAppWrite();
    return isLogged ? LoginStatus.connected : LoginStatus.disconnected;
  }

  void openLoginPage() {
    AppWriteUserService().login();
  }
}
