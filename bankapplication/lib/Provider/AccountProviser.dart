import 'package:bankapplication/Models/Account_Models.dart';
import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  List<AcountModels> _accountList = [];
  List<AcountModels> get accountList => _accountList;
  void setAccountList(List<AcountModels> value) {
    _accountList = value;
  }

  double _totalBalance = 0;
  double get totalBalance => _totalBalance;
  void setTotalBalance(double value) {
    _totalBalance = _totalBalance + value;
  }

  String _accountNumberSelect = "";
  String get accountNumberSelect => _accountNumberSelect;
  void setAccountNumberSelect(String value) {
    _accountNumberSelect = value;
    notifyListeners();
  }

  double _balanceSelect = 0;
  double get balanceSelect => _balanceSelect;
  void setBalanceSelect(double value) {
    _balanceSelect = value;
    notifyListeners();
  }

  String _accountType = "";
  String get accountType => _accountType;
  void setAccountType(String value) {
    if (value == "SAVINGS") {
      _accountType = "ออมทรัพย์ ";
    }
    if (value == "CURRENT") {
      _accountType = "กระแสรายวัน ";
    }
    if (value == "FIXEDDEPOSIT") {
      _accountType = "ฝากประจำ ";
    }

    notifyListeners();
  }

  String _checkpageStatement = "AdmissionList";
  String get checkpageStatement => _checkpageStatement;
  void setCheckpageStatement(String value) {
    _checkpageStatement = value;
    notifyListeners();
  }

  String _typeOpenAccount = "";
  String get typeOpenAccount => _typeOpenAccount;
  void setTypeOpenAccount(String value) {
    if (value == "ออมทรัพย์ ") {
      _typeOpenAccount = "SAVINGS";
    }
    if (value == "กระแสรายวัน ") {
      _typeOpenAccount = "CURRENT";
    }
    if (value == "ฝากประจำ ") {
      _typeOpenAccount = "FIXEDDEPOSIT";
    }

    notifyListeners();
  }

  String _typeOpenAccountShow = "ออมทรัพย์ ";
  String get typeOpenAccountShow => _typeOpenAccountShow;
  void setTypeOpenAccountShow(String value) {
    _typeOpenAccountShow = value;

    notifyListeners();
  }
}
