class AcountModels {
  final String accountID;
  final String accountNumber;
  final double balance;
  final String accountType;
  AcountModels(
      {required this.accountID,
      required this.accountNumber,
      required this.balance,
      required this.accountType});

  AcountModels.fromJson(parsedJson)
      : accountID = parsedJson['accountID'],
        accountNumber = parsedJson['accountNumber'],
        balance = parsedJson['balance'],
        accountType = parsedJson['accountType'];
}
