import 'package:jbfr_april_fp/services/appwrite/appwrite_user_service.dart';
import 'package:jbfr_april_fp/services/user_service.dart';

class UnlockDialogController {
  
  Future<bool> tryPassword(String password, String folder) async {
    bool result = await AppWriteUserService().tryPassword(password, folder);
    await UserService().updateGameFolders();
    return result;
  }
}
