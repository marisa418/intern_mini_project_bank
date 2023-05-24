class HistoryStatementModels {
  final String accountNumber;
  final String action;
  final String assignorID;
  final double amount;
  final double fee;
  final double total;
  final DateTime timestamp;
  final String toAccount;
  final String toFirstName;
  final String toLastName;
  HistoryStatementModels({
    required this.accountNumber,
    required this.action,
    required this.assignorID,
    required this.amount,
    required this.fee,
    required this.total,
    required this.timestamp,
    required this.toAccount,
    required this.toFirstName,
    required this.toLastName,
  });

  HistoryStatementModels.fromJson(parsedJson)
      : accountNumber = parsedJson['accountNumber'],
        action = parsedJson['action'],
        assignorID = parsedJson['assignorID'],
        amount = parsedJson['amount'],
        fee = parsedJson['fee'],
        total = parsedJson['total'],
        timestamp = DateTime.parse(parsedJson['timestamp']),
        toAccount = parsedJson['toAccount'] ?? "Null",
        toFirstName = parsedJson['toFirstName'] ?? "Null",
        toLastName = parsedJson['toLastName'] ?? "Null";
}
