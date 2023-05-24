class PromtPayModels {
  final String phone;
  final String identificationID;

  PromtPayModels({
    required this.phone,
    required this.identificationID,
  });

  PromtPayModels.fromJson(parsedJson)
      : phone = parsedJson['phone'] ?? "Null",
        identificationID = parsedJson['identificationID'] ?? "Null";
}
