import 'package:flutter/material.dart';

class TransferProvider extends ChangeNotifier {
  String _transactionIDTransfer = "";
  String get transactionIDTransfer => _transactionIDTransfer;
  void setTtransactionIDTransfer(String value) {
    _transactionIDTransfer = value;
    notifyListeners();
  }

  double _amountTransfer = 0;
  double get amountTransfer => _amountTransfer;
  void setAmountTransfer(double value) {
    _amountTransfer = value;
    notifyListeners();
  }

  double _feeTransfer = 0;
  double get feeTransfer => _feeTransfer;
  void setFeeTransfer(double value) {
    _feeTransfer = value;
    notifyListeners();
  }

  String _toFirstNameTransfer = "";
  String get toFirstNameTransfer => _toFirstNameTransfer;
  void setToFirstNameTransfer(String value) {
    _toFirstNameTransfer = value;
    notifyListeners();
  }

  String _toLastNameTransfer = "";
  String get toLastNameTransfer => _toLastNameTransfer;
  void setToLastNameTransfer(String value) {
    _toLastNameTransfer = value;
    notifyListeners();
  }

  String _toAccountTransfer = "1111111111";
  String get toAccountTransfer => _toAccountTransfer;
  void setToAccountTransfer(String value) {
    _toAccountTransfer = value;
    notifyListeners();
  }

  String _toIdentificationID = "1111111111111";
  String get toIdentificationID => _toIdentificationID;
  void setToIdentificationID(String value) {
    _toIdentificationID = value;
    notifyListeners();
  }

  String _toPhoneNumber = "1111111111";
  String get toPhoneNumber => _toPhoneNumber;
  void setToPhoneNumber(String value) {
    _toPhoneNumber = value;
    notifyListeners();
  }

  DateTime _timestampTransfer = DateTime.now();
  DateTime get timestampTransfer => _timestampTransfer;
  void setTimestampTransfer(DateTime value) {
    _timestampTransfer = value;
    notifyListeners();
  }

  String _checkTypeTransfer = "PromptPay";
  String get checkTypeTransfer => _checkTypeTransfer;
  void setCheckTypeTransfer(String value) {
    _checkTypeTransfer = value;
    notifyListeners();
  }

  String _checkTypePromptPay = "PhoneNumber";
  String get checkTypePromptPay => _checkTypePromptPay;
  void setCheckTypePromptPay(String value) {
    _checkTypePromptPay = value;
    notifyListeners();
  }
}
