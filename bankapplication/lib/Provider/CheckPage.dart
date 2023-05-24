import 'package:flutter/material.dart';

class CheckPage extends ChangeNotifier {
  String _checkPageinHome = "Account";
  String get checkPageinHome => _checkPageinHome;
  void setCheckPageinHome(String value) {
    _checkPageinHome = value;
    notifyListeners();
  }

  bool _isErrorPageWithdraw = false;
  bool get isErrorPageWithdraw => _isErrorPageWithdraw;
  void setIsErrorPageWithdraw(bool value) {
    _isErrorPageWithdraw = value;
    notifyListeners();
  }

  bool _isErrorPageTransfer = false;
  bool get isErrorPageTransfer => _isErrorPageTransfer;
  void setIsErrorPageTransfer(bool value) {
    _isErrorPageTransfer = value;
    notifyListeners();
  }
}
