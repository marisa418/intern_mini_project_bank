class UpdateBalance {
  final double balance;

  UpdateBalance({
    required this.balance,
  });

  factory UpdateBalance.fromJson(Map<String, dynamic> parsedJson) {
    var balance = UpdateBalance(
      balance: parsedJson['balance'],
    );
    return balance;
  }
}

class OtherTransfer {
  final String transactionID;
  final double amount;
  final double fee;
  final String toFirstName;
  final String toLastName;
  final String toAccount;
  final String toIdentificationID;
  final String toPhoneNumber;
  final DateTime timestamp;

  OtherTransfer({
    required this.transactionID,
    required this.amount,
    required this.fee,
    required this.toFirstName,
    required this.toLastName,
    required this.toAccount,
    required this.toIdentificationID,
    required this.toPhoneNumber,
    required this.timestamp,
  });

  factory OtherTransfer.fromJson(Map<String, dynamic> parsedJson) {
    var balance = OtherTransfer(
      transactionID: parsedJson['transactionID'],
      amount: parsedJson['amount'],
      fee: parsedJson['fee'],
      toFirstName: parsedJson['toFirstName'],
      toLastName: parsedJson['toLastName'],
      toAccount: parsedJson['toAccount'],
      toPhoneNumber: parsedJson['toPhoneNumber'] ?? "Null",
      toIdentificationID: parsedJson['toIdentificationID'] ?? "Null",
      timestamp: DateTime.parse(parsedJson['timestamp']),
    );
    return balance;
  }
}
