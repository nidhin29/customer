import 'package:customer/Domain/TokenManager/token_manager.dart';
import 'package:customer/Domain/TokenManager/token_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: TokenService)
class TokenRepo implements TokenService {
  @override
  Future deleteEmail() async {
    final sharedPref = SharedPreferences.getInstance();
    sharedPref.then((value) {
      value.remove('email');
    });
    return;
  }

  @override
  Future saveEmail() async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('email', TokenManager.instance.email!);
    final user = TokenManager.instance.user!;
    if (user == '2') {
await sharedPref.setString('staff', TokenManager.instance.stafftype!);
    }
    
    return;
  }
}
