class LoginAuthModel {
  String? password, email, serverUrl, _userType;

  set userType(value) {
    (value == 0) ? _userType = "owner" : _userType = "staff";
  }

  get userType {
    if (_userType == null) {
      return "Choose User Type";
    } else {
      return _userType;
    }
  }
}
