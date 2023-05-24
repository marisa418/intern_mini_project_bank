import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Models/PromtPay_Models.dart';
import 'package:bankapplication/Page/ATM/ManageATM.dart';
import 'package:bankapplication/Page/ListAccount.dart';
import 'package:bankapplication/Page/Login.dart';
import 'package:bankapplication/Page/Setting/PromtPay/CreatePromtPay.dart';
import 'package:bankapplication/Page/Setting/Setting.dart';
import 'package:bankapplication/Provider/PromtPayProvider.dart';
import 'package:bankapplication/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class PromtPay extends ConsumerWidget {
  final String title = "จัดการพร้อมเพย์";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60, child: HeadAccountOption(title)),
          SizedBox(height: 600, child: DetailPromtPay()),
          Container(
            alignment: Alignment.topRight,
            height: 60,
            child: ButtonCreatePromtPay(),
          ),
        ],
      ),
    );
  }
}

class DetailPromtPay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String firstName = ref.watch(loginProvider).firstName;
    final String lastName = ref.watch(loginProvider).lastName;
    final String accountNumber = ref.watch(accountProvider).accountNumberSelect;
    final String accountType = ref.watch(accountProvider).accountType;

    final lengthOfAccountPromtPay =
        ref.watch(promtPayProvider).accountPromtpay.length;
    return Scaffold(
      body: ListView.builder(
          itemCount: lengthOfAccountPromtPay,
          itemBuilder: (context, index) {
            final accountListPromtPay =
                ref.watch(promtPayProvider).accountPromtpay[index];
            if (accountListPromtPay.identificationID != "Null" &&
                accountListPromtPay.phone == "Null") {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  width: 380,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xff49A9A0),
                    border: Border.all(
                      color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            firstName + "  " + lastName,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            accountListPromtPay.identificationID
                                .replaceRange(3, 12, "X-X-XXXXX-"),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  width: 380,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xff49A9A0),
                    border: Border.all(
                      color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            firstName + "  " + lastName,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            accountListPromtPay.phone
                                .replaceRange(2, 9, "X-X-XXXXX-"),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}

class ButtonCreatePromtPay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        alignment: Alignment.center,
        width: 380,
        height: 60,
        decoration: BoxDecoration(
            color: Color(0xff49A9A0),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: FlatButton(
            child: const Text(
              "สมัครพร้อมเพย์ ",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              if (ref.watch(promtPayProvider).accountPromtpay.length == 4) {
                const SnackBarLogin = SnackBar(
                  content: Text("ท่านสมัครพร้อมเพย์ได้มากสุด 4 หมายเลข",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                  duration: Duration(seconds: 3),
                );
                ScaffoldMessenger.of(context).showSnackBar(SnackBarLogin);
              } else {
                Navigator.pushNamed(context, '/CreatePromtPay');
              }
            }),
      ),
    );
  }
}
