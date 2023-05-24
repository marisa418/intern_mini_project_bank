import 'package:bankapplication/Models/User_Models.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
  UserModels? _user;
  get user => _user;
  void setUser(UserModels? value) {
    _user = value;
    notifyListeners();
  }

  String _identificationIDLogin = "1211111111111";
  String get identificationIDLogin => _identificationIDLogin;
  void setidentificationIDLogin(String value) {
    _identificationIDLogin = value;
    notifyListeners();
  }

  String _passwordLogin = "Abc123";
  String get passwordLogin => _passwordLogin;
  void setPasswordLogin(String value) {
    _passwordLogin = value;
    notifyListeners();
  }

  String _firstName = "";
  String get firstName => _firstName;
  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  String _lastName = "";
  String get lastName => _lastName;
  void setLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  String _userID = "";
  String get userID => _userID;
  void setUserID(String value) {
    _userID = value;
    notifyListeners();
  }

  String _prefix = "";
  String get prefix => _prefix;
  void setPrefix(String value) {
    _prefix = value;
    notifyListeners();
  }
}
