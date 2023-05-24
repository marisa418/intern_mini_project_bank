import 'package:bankapplication/Models/History_Statement_Models.dart';
import 'package:flutter/material.dart';

class HistoryStatementProvider extends ChangeNotifier {
  List<HistoryStatementModels> _historyStatement = [];
  List<HistoryStatementModels> get historyStatement => _historyStatement;
  void setHistoryStatement(List<HistoryStatementModels> value) {
    _historyStatement = value;
  }
}
