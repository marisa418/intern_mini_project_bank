import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  String _prefix = "";
  String get prefix => _prefix;
  void setPrefix(String value) {
    _prefix = value;
    notifyListeners();
  }

  String _identificationID = "";
  String get identificationID => _identificationID;
  void setidentificationID(String value) {
    _identificationID = value;
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

  bool _validatePrefix = false;
  bool get validatePrefix => _validatePrefix;
  void setValidatePrefixd(bool value) {
    _validatePrefix = value;
    notifyListeners();
  }

  String _confirmPassword = "";
  String get confirmPassword => _confirmPassword;
  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }
}
