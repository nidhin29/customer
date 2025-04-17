class TokenManager {
  TokenManager._internal();
  static TokenManager instance = TokenManager._internal();
  factory TokenManager() => instance;

  String? _email;
  String? _password;
  String? _stafftype;
  String? _user;

  String? get email => _email;
  String? get password => _password;
  String? get stafftype => _stafftype;
  String? get user => _user;

  setEmail(String email) {
    _email = email;
  }

  setPassword(String password) {
    _password = password;
  }

  setStaffType(String stafftype) {
    _stafftype = stafftype;
  }

  setUser(String user) {
    _user = user;
  }
}
