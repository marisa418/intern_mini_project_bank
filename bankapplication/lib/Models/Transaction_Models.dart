class TransactionModels {
  final String account;
  final String action;
  final DateTime timestamp;
  final String firstName;
  final String lastName;
  final double amount;
  final double fee;
  final double total;
  final String toFirstName;
  final String toLastName;
  final String toAccount;

  TransactionModels({
    required this.account,
    required this.action,
    required this.timestamp,
    required this.firstName,
    required this.lastName,
    required this.amount,
    required this.fee,
    required this.total,
    required this.toFirstName,
    required this.toLastName,
    required this.toAccount,
  });

  TransactionModels.fromJson(parsedJson)
      : account = parsedJson['transRabbitID'],
        action = parsedJson['transRabbitID'],
        timestamp = DateTime.parse(parsedJson['timeStamp']),
        firstName = parsedJson['transRabbitID'],
        lastName = parsedJson['transRabbitID'],
        amount = parsedJson['transRabbitID'],
        fee = parsedJson['transRabbitID'],
        total = parsedJson['transRabbitID'],
        toFirstName = parsedJson['transRabbitID'],
        toLastName = parsedJson['transRabbitID'],
        toAccount = parsedJson['transRabbitID'];
}
