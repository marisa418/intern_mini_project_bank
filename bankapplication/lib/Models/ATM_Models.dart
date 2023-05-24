class ATMModels {
  final String accountAtmID;
  final String accountAtmNumber;
  final String accountNumber;
  final String pin;
  final String accountAtmStatus;
  ATMModels(
      {required this.accountAtmID,
      required this.accountAtmNumber,
      required this.accountNumber,
      required this.pin,
      required this.accountAtmStatus});

  ATMModels.fromJson(parsedJson)
      : accountAtmID = parsedJson['accountAtmID'],
        accountAtmNumber = parsedJson['accountAtmNumber'],
        accountNumber = parsedJson['accountNumber'],
        pin = parsedJson['pin'],
        accountAtmStatus = parsedJson['accountAtmStatus'];
}
