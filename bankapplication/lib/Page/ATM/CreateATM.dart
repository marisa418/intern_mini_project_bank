import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Models/Response_Option_Models.dart';
import 'package:bankapplication/Page/ATM/ManageATM.dart';
import 'package:bankapplication/Page/Home.dart';
import 'package:bankapplication/Page/ListAccount.dart';
import 'package:bankapplication/Page/Login.dart';
import 'package:bankapplication/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateATM extends ConsumerWidget {
  final String title = "สมัครบัตรATM";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 60, child: HeadAccountOption(title)),
          SizedBox(height: 520, child: FormCreate()),
        ],
      ),
    );
  }
}

class FormCreate extends ConsumerWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  TextEditingController conpinController = TextEditingController();

  UpdateBalance? endBalance;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        child: Form(
          key: formKey,
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
                    "เลขบัญชี",
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
                    " " + ref.watch(accountProvider).accountNumberSelect,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Pin",
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
                    obscureText: true,
                    controller: pinController,
                    validator: (Pin) {
                      if (Pin!.isEmpty) {
                        return 'กรุณาใส่ข้อมูล';
                      } else if (Pin.length < 6) {
                        return 'Pin ต้องมี 6 หลัก';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(6),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(6),
                      hintText: 'Pin',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Confirm Pin",
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
                    obscureText: true,
                    controller: conpinController,
                    validator: (conpin) {
                      if (conpin!.isEmpty) {
                        return 'กรุณาใส่ข้อมูล';
                      } else if (conpin.length < 6) {
                        return 'Pin ต้องมี 6 หลัก';
                      } else if (pinController.text != conpinController.text) {
                        return 'Pin ไม่ตรงกัน';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(6),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(6),
                      hintText: 'Confirm Pin',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
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
                      final accountNumber =
                          ref.watch(accountProvider).accountNumberSelect;

                      http.Response responseCreateATM = await SendCreateATM(
                          accountNumber,
                          pinController.text,
                          conpinController.text);

                      if (responseCreateATM.statusCode == 200) {
                        ref.read(getATMProvider).setSsHaveATM(true);

                        await Navigator.pushNamed(context, '/Home');
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
