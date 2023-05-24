import 'package:bankapplication/Models/ATM_Models.dart';
import 'package:bankapplication/Models/Account_Models.dart';
import 'package:bankapplication/Models/History_Statement_Models.dart';
import 'package:bankapplication/Models/PromtPay_Models.dart';
import 'package:bankapplication/Models/Transaction_Models.dart';
import 'package:bankapplication/Models/User_Models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> LoginUser(String identificationID, String password) {
  final response = http.post(
    Uri.parse('http://192.168.86.93:8082/bank/api/v1/user/loginUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'identificationID': identificationID,
      'password': password,
    }),
  );

  return response;
}

Future<http.Response> RegisterUser(
    String firstName,
    String lastName,
    String identificationID,
    String password,
    String checkPassword,
    String prefix) {
  return http.post(
    Uri.parse('http://192.168.86.93:8082/bank/api/v1/user/registerUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstName': firstName,
      'lastName': lastName,
      'identificationID': identificationID,
      'password': password,
      'checkPassword': checkPassword,
      'prefix': prefix,
    }),
  );
}

Future<http.Response> SendCreateAccount(
  String userID,
  String accountType,
  String amount,
) {
  return http.post(
    Uri.parse(
        'http://192.168.86.93:8082/bank/api/v1/account/openAccount/{userID}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'userID': userID,
      'accountType': accountType,
      'amount': amount,
    }),
  );
}

Future<http.Response> SendWithdraw(
  String accountNumber,
  String amount,
) {
  return http.post(
    Uri.parse('http://192.168.86.93:8082/bank/api/v1/account/withdraw'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'accountNumber': accountNumber,
      'amount': amount,
    }),
  );
}

Future<http.Response> SendDeposit(
  String accountNumber,
  String amount,
) {
  return http.post(
    Uri.parse('http://192.168.86.93:8082/bank/api/v1/account/deposit'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'accountNumber': accountNumber,
      'amount': amount,
    }),
  );
}

Future<http.Response> SendTransfer(
  String accountNumber,
  String toAccountNumber,
  String amount,
) {
  return http.post(
    Uri.parse('http://192.168.86.93:8082/bank/api/v1/account/transfer'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'accountNumber': accountNumber,
      'toAccountNumber': toAccountNumber,
      'amount': amount,
    }),
  );
}

Future<http.Response> SendTransferPromtPayByPhone(
  String accountNumber,
  String toPhoneNumber,
  String amount,
) {
  return http.post(
    Uri.parse(
        'http://192.168.86.93:8082/bank/api/v1/promaptpay/transferPhonePromptpay'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'accountNumber': accountNumber,
      'toPhoneNumber': toPhoneNumber,
      'amount': amount,
    }),
  );
}

Future<http.Response> SendTransferPromtPayByID(
  String accountNumber,
  String toIdentificationID,
  String amount,
) {
  return http.post(
    Uri.parse(
        'http://192.168.86.93:8082/bank/api/v1/promaptpay/transferIdentifiactionIDPromptpay'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'accountNumber': accountNumber,
      'toIdentificationID': toIdentificationID,
      'amount': amount,
    }),
  );
}

Future<List<AcountModels>> getAccount(String userID) async {
  List<AcountModels> acount = [];
  try {
    final response = await http.get(
      Uri.parse('http://192.168.86.93:8082/bank/api/v1/user/getUserAccounts/' +
          userID),
    );
    print("xxxxxxxx");
    print(
        'http://192.168.86.93:8082/bank/api/v1/user/getUserAccounts/' + userID);
    print(response.body);

    acount = jsonDecode(response.body)
        .map<AcountModels>((json) => AcountModels.fromJson(json))
        .toList();
    print(acount);
    return acount;
  } catch (e) {
    return [];
  }
}

Future<List<HistoryStatementModels>> getHistoryStatementModels(
    String accountNumber) async {
  List<HistoryStatementModels> HistoryStatement = [];
  try {
    final response = await http.get(
      Uri.parse(
          'http://192.168.86.93:8082/bank/api/v1/account/getHistoryByAccountNumber?accountNumber=' +
              accountNumber),
    );
    HistoryStatement = jsonDecode(response.body)
        .map<HistoryStatementModels>(
            (json) => HistoryStatementModels.fromJson(json))
        .toList();

    return HistoryStatement;
  } catch (e) {
    return [];
  }
}

Future<List<ATMModels>> getAtmByAccounNumber(String accountNumber) async {
  List<ATMModels> atmList = [];
  try {
    final response = await http.get(
      Uri.parse(
          'http://192.168.86.93:8082/bank/api/v1/ATM/account/accountAtmByAccounNumber?accountNumber= ' +
              accountNumber),
    );
    atmList = jsonDecode(response.body)
        .map<ATMModels>((json) => ATMModels.fromJson(json))
        .toList();

    return atmList;
  } catch (e) {
    return [];
  }
}

Future<http.Response> SendCreateATM(
  String accountNumber,
  String pin,
  String checkPin,
) {
  return http.post(
    Uri.parse(
        'http://192.168.86.93:8082/bank/api/v1/ATM/account/openAccountATM'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'accountNumber': accountNumber,
      'pin': pin,
      'checkPin': checkPin,
    }),
  );
}

Future<http.Response> SendCloseATM(
  String accountAtmNumber,
) {
  return http.post(
    Uri.parse(
        'http://192.168.86.93:8082/bank/api/v1/ATM/account/statusAtm/close/' +
            accountAtmNumber),
  );
}

//PrompPay
Future<List<PromtPayModels>> getAccountPromptPay(String accountNumber) async {
  List<PromtPayModels> accountPromptPay = [];
  try {
    final response = await http.get(
      Uri.parse(
          'http://192.168.86.93:8082/bank/api/v1/promaptpay/getPromptPay?accountNumber=' +
              accountNumber),
    );
    accountPromptPay = jsonDecode(response.body)
        .map<PromtPayModels>((json) => PromtPayModels.fromJson(json))
        .toList();

    return accountPromptPay;
  } catch (e) {
    return [];
  }
}

Future<http.Response> registerPromptpayByPhone(
  String accountNumber,
  String phone,
) {
  return http.post(
    Uri.parse(
        'http://192.168.86.93:8082/bank/api/v1/promaptpay/registerPromptpayByPhone'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'accountNumber': accountNumber,
      'phone': phone,
    }),
  );
}

Future<http.Response> registerPromptpayByID(
  String accountNumber,
  String identificationID,
) {
  return http.post(
    Uri.parse(
        'http://192.168.86.93:8082/bank/api/v1/promaptpay/registerPromptpayByIdentificationID'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'accountNumber': accountNumber,
      'identificationID': identificationID,
    }),
  );
}
