import 'package:customer/Domain/LoggedIn/logged_in_service.dart';
import 'package:customer/Domain/TokenManager/token_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: LoggedInService)
class LoggedInRepo implements LoggedInService {
  @override
  Future<bool> isLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();
    final email = sharedPref.getString('email');
    if (email == null) {
      return false;
    } else {
      final staff = sharedPref.getString('staff');
      final user = sharedPref.getString('user');
      if(staff != null) {
        TokenManager.instance.setStaffType(staff);
      } else {
        TokenManager.instance.setStaffType('0');
      }
   
      await TokenManager.instance.setUser(user!);
      return true;
    }
  }
}
