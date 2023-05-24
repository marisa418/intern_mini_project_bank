import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Models/Response_Option_Models.dart';
import 'package:bankapplication/Page/ListAccount.dart';
import 'package:bankapplication/Page/Login.dart';
import 'package:bankapplication/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAccount extends ConsumerWidget {
  final String title = "เปิดบัญชี";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 60, child: HeadAccountOption(title)),
          SizedBox(height: 620, child: CreateAccount()),
        ],
      ),
    );
  }
}

class CreateAccount extends ConsumerWidget {
  TextEditingController amountController = TextEditingController();
  List<String> typeOpenAccount = ["ออมทรัพย์ ", "กระแสรายวัน ", "ฝากประจำ "];
  UpdateBalance? endBalance;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "ชื่อ-นามสกุล",
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
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
                child: Text(
                  " " +
                      ref.watch(loginProvider).firstName +
                      "  " +
                      ref.watch(loginProvider).lastName,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "เลขประจำตัวประชาชน",
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
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
                child: Text(
                  " " + ref.watch(loginProvider).identificationIDLogin,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ประเภทบัญชี ",
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 44, 44, 44)
                            .withOpacity(0.2),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text(
                              ref.watch(accountProvider).typeOpenAccountShow),
                          items: typeOpenAccount.map((results) {
                            return DropdownMenuItem(
                                child: Text(results), value: results);
                          }).toList(),
                          onChanged: (value) {
                            ref
                                .read(accountProvider)
                                .setTypeOpenAccount(value.toString());
                            ref
                                .read(accountProvider)
                                .setTypeOpenAccountShow(value.toString());
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "ยอดเงินเปิดบัญชี",
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
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
                    labelText: 'จำนวนเงิน',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
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
                    final userID = ref.watch(loginProvider).userID;
                    print(ref.watch(accountProvider).typeOpenAccount);
                    http.Response responseCreateAccount =
                        await SendCreateAccount(
                            userID,
                            ref.watch(accountProvider).typeOpenAccount,
                            amountController.text);
                    print(responseCreateAccount.statusCode);
                    if (responseCreateAccount.statusCode == 200) {
                      await Navigator.pushNamed(context, '/Home');
                    } else {
                      const SnackBarLogin = SnackBar(
                        content: Text("ไม่สำเร็จ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                        duration: Duration(seconds: 1),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBarLogin);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
