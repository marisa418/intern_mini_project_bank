import 'package:bankapplication/Models/ATM_Models.dart';
import 'package:bankapplication/Models/History_Statement_Models.dart';
import 'package:flutter/material.dart';

class ATMProvider extends ChangeNotifier {
  List<ATMModels> _atm = [];
  List<ATMModels> get atm => _atm;
  void setAtm(List<ATMModels> value) {
    _atm = value;
  }

  String _accountAtmNumber = "";
  String get accountAtmNumber => _accountAtmNumber;
  void setAccountAtmNumber(String value) {
    _accountAtmNumber = value;
  }

  bool _isHaveATM = true;
  bool get isHaveATM => _isHaveATM;
  void setSsHaveATM(bool value) {
    _isHaveATM = value;
  }
}
