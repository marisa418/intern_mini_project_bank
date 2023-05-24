import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Page/ListAccount.dart';
import 'package:bankapplication/Page/Setting/PromtPay/PromtPay.dart';
import 'package:bankapplication/Page/Setting/Setting.dart';
import 'package:bankapplication/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreatePromtPay extends ConsumerWidget {
  final String title = "สมัครพร้อมเพย์";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 60, child: HeadAccountOption(title)),
          SizedBox(height: 60, child: SelectTypePromtPay()),
          SizedBox(height: 600, child: FormCreate()),
        ],
      ),
    );
  }
}

class SelectTypePromtPay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String typePP = ref.watch(promtPayProvider).selectType;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 180,
                height: 50,
                decoration: BoxDecoration(
                    color: typePP == "IdentificationID"
                        ? Color(0xff49A9A0)
                        : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                  "บัตรประชาชน",
                  style: TextStyle(
                      fontSize: 18,
                      color: typePP == "IdentificationID"
                          ? Colors.white
                          : Color(0xff49A9A0)),
                ),
              ),
              onTap: () {
                ref.read(promtPayProvider).setSelectType("IdentificationID");
              },
            ),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 180,
                height: 50,
                decoration: BoxDecoration(
                    color: typePP == "Phone" ? Color(0xff49A9A0) : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                  "หมายเลขโทรศัพท์ ",
                  style: TextStyle(
                      fontSize: 18,
                      color:
                          typePP == "Phone" ? Colors.white : Color(0xff49A9A0)),
                ),
              ),
              onTap: () {
                ref.read(promtPayProvider).setSelectType("Phone");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FormCreate extends ConsumerWidget {
  TextEditingController inputController =
      TextEditingController(text: "0435699345");
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(promtPayProvider).selectType == "IdentificationID") {
      return FormCreateID();
    }
    if (ref.watch(promtPayProvider).selectType == "Phone") {
      return FormCreatePhone();
    }
    return Container();
  }
}

class FormCreateID extends ConsumerWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
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
              child: Form(
                key: formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.length < 13) {
                      return 'เลขบัตรประชาชนต้องมี 13 หลัก';
                    }
                    return null;
                  },
                  controller: inputController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(13),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                    contentPadding: const EdgeInsets.all(6),
                    hintText: 'เลขประจำตัวประชาชน ',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ),
          Container(
              alignment: Alignment.topRight,
              child: Text("* เลขประจำตัวประชาชนต้องตรงกับที่ลงทะเบียน")),
          Padding(
            padding: const EdgeInsets.only(top: 400),
            child: Container(
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                  color: Color(0xff49A9A0),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: FlatButton(
                child: const Text(
                  "ลงทะเบียน",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    http.Response responseregisterPromptpayByID =
                        await registerPromptpayByID(
                            ref.watch(accountProvider).accountNumberSelect,
                            inputController.text);

                    print(responseregisterPromptpayByID.statusCode);
                    if (responseregisterPromptpayByID.statusCode == 200) {
                      const SnackBarLogin = SnackBar(
                        content: Text("สำเร็จ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBarLogin);

                      Navigator.pushNamed(context, '/Home');
                    } else {
                      const SnackBarLogin = SnackBar(
                        content: Text("ไม่สำเร็จ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBarLogin);
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormCreatePhone extends ConsumerWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController inputController =
      TextEditingController(text: "0846283476");
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
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
              child: Form(
                key: formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.length < 10) {
                      return 'หมายเลขโทรศัพท์ต้องมี 10 หลัก';
                    }
                    return null;
                  },
                  controller: inputController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                    contentPadding: const EdgeInsets.all(6),
                    hintText: 'หมายเลขโทรศัพท์ ',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 400),
            child: Container(
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                  color: inputController.text.isEmpty
                      ? Color.fromARGB(255, 17, 17, 17).withOpacity(0.4)
                      : Color(0xff49A9A0),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: FlatButton(
                child: const Text(
                  "ลงทะเบียน",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    http.Response responseregisterPromptpayByPhone =
                        await registerPromptpayByPhone(
                            ref.watch(accountProvider).accountNumberSelect,
                            inputController.text);

                    print(responseregisterPromptpayByPhone.statusCode);
                    if (responseregisterPromptpayByPhone.statusCode == 200) {
                      const SnackBarLogin = SnackBar(
                        content: Text("สำเร็จ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBarLogin);

                      Navigator.pushNamed(context, '/Home');
                    } else {
                      const SnackBarLogin = SnackBar(
                        content: Text("ไม่สำเร็จ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBarLogin);
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
