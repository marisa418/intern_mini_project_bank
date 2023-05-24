import 'package:bankapplication/Models/PromtPay_Models.dart';
import 'package:flutter/material.dart';

class PromtPayProvider extends ChangeNotifier {
  List<PromtPayModels> _accountPromtpay = [];
  List<PromtPayModels> get accountPromtpay => _accountPromtpay;
  void setAccountPromtpayt(List<PromtPayModels> value) {
    _accountPromtpay = value;
  }

  String _selectType = "IdentificationID";
  String get selectType => _selectType;
  void setSelectType(String value) {
    _selectType = value;
    notifyListeners();
  }

  String _inputID = "";
  String get inputID => _inputID;
  void setInputID(String value) {
    _inputID = value;
    notifyListeners();
  }

  String _inputPhone = "";
  String get inputPhone => _inputPhone;
  void setInputPhone(String value) {
    _inputPhone = value;
    notifyListeners();
  }

  int _length = 0;
  int get length => _length;
  void setLength(int value) {
    _length = _accountPromtpay.length;
    notifyListeners();
  }
}
