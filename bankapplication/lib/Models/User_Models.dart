class UserModels {
  final String userID;
  final String firstName;
  final String lastName;
  final String identificationID;
  final String prefix;

  UserModels({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.identificationID,
    required this.prefix,
  });
  // factory UserModels.fromJson(Map<String, dynamic> parsedJson) => UserModels(
  //     userID: parsedJson['userID'],
  //     firstName: parsedJson['firstName'],
  //     lastName: parsedJson['lastName'],
  //     identificationID: parsedJson['identificationID'],
  //     prefix: parsedJson['prefix']);

  factory UserModels.fromJson(Map<String, dynamic> parsedJson) {
    var user = UserModels(
      userID: parsedJson['userID'],
      firstName: parsedJson['firstName'],
      lastName: parsedJson['lastname'],
      identificationID: parsedJson['identificationID'],
      prefix: parsedJson['prefix'],
    );
    return user;
  }
}
