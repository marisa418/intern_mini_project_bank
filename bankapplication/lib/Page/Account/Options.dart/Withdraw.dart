import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Models/Response_Option_Models.dart';
import 'package:bankapplication/Page/Account/Account.dart';
import 'package:bankapplication/Page/Home.dart';
import 'package:bankapplication/Page/ListAccount.dart';
import 'package:bankapplication/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Withdraw extends ConsumerWidget {
  final String title = "ถอนเงิน";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        // reverse: true,
        children: [
          SizedBox(height: 60, child: HeadAccountOption(title)),
          SizedBox(height: 120, child: DetailAccount()),
          const SizedBox(
            height: 30,
          ),
          SizedBox(height: 400, child: FormWithdraw()),
        ],
      ),
    );
  }
}

class FormWithdraw extends ConsumerWidget {
  TextEditingController amountController = TextEditingController();
  UpdateBalance? endBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController accountNumberController = TextEditingController(
        text: ref.watch(accountProvider).accountNumberSelect);
    final bool isError = ref.watch(checkPage).isErrorPageWithdraw;
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black.withOpacity(0.1),
                width: 4.0,
              ),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "จำนวนเงิน",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                      width: 1,
                    ),
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(13),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(6),
                      hintText: 'จำนวนเงิน',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 5),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "จำนวนเงินในบัญชีมีไม่เพียงพอ",
                    style: TextStyle(
                        fontSize: 16,
                        color: isError == true ? Colors.red : Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Container(
                  width: 380,
                  height: 60,
                  decoration: const BoxDecoration(
                      color: Color(0xff49A9A0),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: FlatButton(
                    child: const Text(
                      "ยืนยัน",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () async {
                      if (double.parse(amountController.text) >
                          ref.watch(accountProvider).balanceSelect) {
                        ref.read(checkPage).setIsErrorPageWithdraw(true);
                      } else {
                        http.Response responseWithdraw = await SendWithdraw(
                            ref.watch(accountProvider).accountNumberSelect,
                            amountController.text);

                        print(responseWithdraw.statusCode);
                        if (responseWithdraw.statusCode == 200) {
                          endBalance = UpdateBalance.fromJson(
                              jsonDecode(responseWithdraw.body));

                          ref
                              .read(accountProvider)
                              .setBalanceSelect(endBalance!.balance);
                          print(ref.watch(accountProvider).totalBalance);
                          ref.read(checkPage).setIsErrorPageWithdraw(false);
                          Navigator.pushNamed(context, '/Home');
                        } else {
                          const SnackBarLogin = SnackBar(
                            content: Text("ไม่สำเร็จ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20)),
                            duration: Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBarLogin);
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
