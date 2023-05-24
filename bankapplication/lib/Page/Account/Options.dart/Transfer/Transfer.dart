import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Models/Response_Option_Models.dart';
import 'package:bankapplication/Page/Account/Account.dart';
import 'package:bankapplication/Page/Account/Options.dart/Transfer/TransferSlip.dart';
import 'package:bankapplication/Page/Home.dart';
import 'package:bankapplication/Page/ListAccount.dart';
import 'package:bankapplication/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Transfer extends ConsumerWidget {
  final String title = "โอนเงิน";
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
          MenuTransfer(),
          SizedBox(height: 450, child: ShowForm()),
        ],
      ),
    );
  }
}

class ShowForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String checkType = ref.watch(transferProvider).checkTypeTransfer;
    if (checkType == "PromptPay") {
      return FormTransferPromptPay();
    }
    if (checkType == "OtherAccount") {
      return FormTransfer();
    }
    // if (checkType == "MyAccount") {
    //   return FormTransfer();
    // }

    return Container();
  }
}

class FormTransfer extends ConsumerWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController toAccountNumberController =
      TextEditingController(text: "8272640180");
  TextEditingController amountController = TextEditingController();
  OtherTransfer? resTransfer;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isError = ref.watch(checkPage).isErrorPageTransfer;
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
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
                        "ไปยัง",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                        width: 1,
                      ),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: toAccountNumberController,
                      // validator: (idCardController) {
                      //   return idCardController!.length > 2000000
                      //       ? 'เลขบัตรประชาชนต้องมี 13 หลัก'
                      //       : null;
                      // },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(13),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(6),
                        labelText: 'เลขบัญชี',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
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
                      // validator: (idCardController) {
                      //   return idCardController!.length > 2000000
                      //       ? 'เลขบัตรประชาชนต้องมี 13 หลัก'
                      //       : null;
                      // },
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
                  padding: const EdgeInsets.only(top: 100),
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
                        final balance =
                            ref.watch(accountProvider).balanceSelect;
                        if (double.parse(amountController.text) >
                            ref.watch(accountProvider).balanceSelect) {
                          ref.read(checkPage).setIsErrorPageTransfer(true);
                        } else {
                          http.Response responseTransfer = await SendTransfer(
                              ref.watch(accountProvider).accountNumberSelect,
                              toAccountNumberController.text,
                              amountController.text);

                          print(responseTransfer.statusCode);
                          if (responseTransfer.statusCode == 200) {
                            resTransfer = OtherTransfer.fromJson(
                                jsonDecode(responseTransfer.body));

                            ref
                                .read(transferProvider)
                                .setTtransactionIDTransfer(
                                    resTransfer!.transactionID);
                            ref
                                .read(transferProvider)
                                .setAmountTransfer(resTransfer!.amount);
                            ref
                                .read(transferProvider)
                                .setFeeTransfer(resTransfer!.fee);
                            ref.read(transferProvider).setToFirstNameTransfer(
                                resTransfer!.toFirstName);
                            ref
                                .read(transferProvider)
                                .setToLastNameTransfer(resTransfer!.toLastName);
                            ref
                                .read(transferProvider)
                                .setToAccountTransfer(resTransfer!.toAccount);
                            ref
                                .read(transferProvider)
                                .setTimestampTransfer(resTransfer!.timestamp);

                            final totalAmount =
                                ref.watch(transferProvider).amountTransfer +
                                    ref.watch(transferProvider).feeTransfer;
                            ref
                                .read(accountProvider)
                                .setBalanceSelect(balance - totalAmount);
                            print(ref.watch(accountProvider).totalBalance);
                            ref.read(checkPage).setIsErrorPageTransfer(false);
                            await Navigator.pushNamed(context, '/TransferSlip');
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
      ),
    );
  }
}

class MenuTransfer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late String checkType = ref.watch(transferProvider).checkTypeTransfer;
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            InkWell(
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: checkType == "PromptPay"
                          ? Color(0xff49A9A0)
                          : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Text(
                    "พร้อมเพย์ ",
                    style: TextStyle(
                      fontSize: 18,
                      color: checkType == "PromptPay"
                          ? Colors.white
                          : Color(0xff49A9A0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  ref.read(transferProvider).setCheckTypeTransfer("PromptPay");

                  ref.read(checkPage).setIsErrorPageTransfer(false);
                }),
            InkWell(
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: checkType == "OtherAccount"
                          ? Color(0xff49A9A0)
                          : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Text(
                    "บัญชีอื่น  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: checkType == "OtherAccount"
                          ? Colors.white
                          : Color(0xff49A9A0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  ref
                      .read(transferProvider)
                      .setCheckTypeTransfer("OtherAccount");

                  ref.read(checkPage).setIsErrorPageTransfer(false);
                }),
            // InkWell(
            //   child: Container(
            //     width: 100,
            //     decoration: BoxDecoration(
            //         color: checkType == "MyAccount"
            //             ? Color(0xff49A9A0)
            //             : Colors.white,
            //         borderRadius: BorderRadius.all(Radius.circular(30))),
            //     child: Text(
            //       "บัญชีตนเอง ",
            //       style: TextStyle(
            //         fontSize: 18,
            //         color: checkType == "MyAccount"
            //             ? Colors.white
            //             : Color(0xff49A9A0),
            //       ),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            //   onTap: () =>
            //       ref.read(transferProvider).setCheckTypeTransfer("MyAccount"),
            // ),
          ],
        ),
      ),
    );
  }
}

class FormTransferPromptPay extends ConsumerWidget {
  List<String> typePromptPay = ["PhoneNumber", "identificationID"];
  OtherTransfer? resTransfer;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
          Container(
            alignment: Alignment.topLeft,
            height: 80,
            child: SelectTypePromptPay(),
          ),
          SizedBox(
            height: 350,
            child: PromptPaytoTel(),
          ),
        ],
      ),
    );
  }
}

class SelectTypePromptPay extends ConsumerWidget {
  List<String> typePromptPay = ["PhoneNumber", "identificationID"];
  OtherTransfer? resTransfer;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: const Text(
                "ไปยัง",
                style: const TextStyle(color: Colors.black, fontSize: 18),
              )),
          Container(
            alignment: Alignment.center,
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  hint: Text(ref.read(transferProvider).checkTypePromptPay),
                  items: typePromptPay.map((results) {
                    return DropdownMenuItem(
                        child: Text(results), value: results);
                  }).toList(),
                  onChanged: (value) {
                    ref
                        .read(transferProvider)
                        .setCheckTypePromptPay(value.toString());
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class PromptPaytoTel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String promtPayType = ref.watch(transferProvider).checkTypePromptPay;
    if (promtPayType == "PhoneNumber") {
      return PromptPaytoPhone();
    }
    if (promtPayType == "identificationID") {
      return PromptPaytoID();
    }
    return Container();
  }
}

class PromptPaytoPhone extends ConsumerWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController =
      TextEditingController(text: "0623087296");
  TextEditingController amountController = TextEditingController();
  OtherTransfer? resTransfer;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isError = ref.watch(checkPage).isErrorPageTransfer;
    final String promtPayType = ref.watch(transferProvider).checkTypePromptPay;

    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                        width: 1,
                      ),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(13),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(6),
                        labelText: 'หมายเลขโทรศัพท์',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
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
                        labelText: 'จำนวนเงิน',
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
                  padding: const EdgeInsets.only(top: 100),
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
                        final balance =
                            ref.watch(accountProvider).balanceSelect;
                        if (double.parse(amountController.text) >
                            ref.watch(accountProvider).balanceSelect) {
                          ref.read(checkPage).setIsErrorPageTransfer(true);
                        } else {
                          http.Response responseTransfer =
                              await SendTransferPromtPayByPhone(
                                  ref
                                      .watch(accountProvider)
                                      .accountNumberSelect,
                                  phoneNumberController.text,
                                  amountController.text);

                          print(responseTransfer.statusCode);
                          if (responseTransfer.statusCode == 200) {
                            resTransfer = OtherTransfer.fromJson(
                                jsonDecode(responseTransfer.body));

                            ref
                                .read(transferProvider)
                                .setTtransactionIDTransfer(
                                    resTransfer!.transactionID);
                            ref
                                .read(transferProvider)
                                .setAmountTransfer(resTransfer!.amount);
                            ref
                                .read(transferProvider)
                                .setFeeTransfer(resTransfer!.fee);
                            ref.read(transferProvider).setToFirstNameTransfer(
                                resTransfer!.toFirstName);
                            ref
                                .read(transferProvider)
                                .setToLastNameTransfer(resTransfer!.toLastName);
                            ref
                                .read(transferProvider)
                                .setToPhoneNumber(resTransfer!.toPhoneNumber);
                            ref
                                .read(transferProvider)
                                .setTimestampTransfer(resTransfer!.timestamp);

                            final totalAmount =
                                ref.watch(transferProvider).amountTransfer +
                                    ref.watch(transferProvider).feeTransfer;
                            ref
                                .read(accountProvider)
                                .setBalanceSelect(balance - totalAmount);
                            print(ref.watch(accountProvider).totalBalance);
                            ref.read(checkPage).setIsErrorPageTransfer(false);
                            await Navigator.pushNamed(context, '/TransferSlip');
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
      ),
    );
  }
}

class PromptPaytoID extends ConsumerWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController idNumberController =
      TextEditingController(text: "1234567890123");
  TextEditingController amountController = TextEditingController();
  OtherTransfer? resTransferPromtPayByID;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isError = ref.watch(checkPage).isErrorPageTransfer;
    final String promtPayType = ref.watch(transferProvider).checkTypePromptPay;

    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                        width: 1,
                      ),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: idNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(13),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(6),
                        labelText: 'เลขบัตรประชาชน ',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
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
                        labelText: 'จำนวนเงิน',
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
                  padding: const EdgeInsets.only(top: 100),
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
                        final balance =
                            ref.watch(accountProvider).balanceSelect;
                        if (double.parse(amountController.text) >
                            ref.watch(accountProvider).balanceSelect) {
                          ref.read(checkPage).setIsErrorPageTransfer(true);
                        } else {
                          http.Response responseTransferPromtPayByID =
                              await SendTransferPromtPayByID(
                                  ref
                                      .watch(accountProvider)
                                      .accountNumberSelect,
                                  idNumberController.text,
                                  amountController.text);

                          print(responseTransferPromtPayByID.statusCode);
                          if (responseTransferPromtPayByID.statusCode == 200) {
                            resTransferPromtPayByID = OtherTransfer.fromJson(
                                jsonDecode(responseTransferPromtPayByID.body));
                            print(resTransferPromtPayByID!.toIdentificationID);
                            print(resTransferPromtPayByID!.transactionID);
                            ref
                                .read(transferProvider)
                                .setTtransactionIDTransfer(
                                    resTransferPromtPayByID!.transactionID);
                            ref.read(transferProvider).setAmountTransfer(
                                resTransferPromtPayByID!.amount);
                            ref
                                .read(transferProvider)
                                .setFeeTransfer(resTransferPromtPayByID!.fee);
                            ref.read(transferProvider).setToFirstNameTransfer(
                                resTransferPromtPayByID!.toFirstName);
                            ref.read(transferProvider).setToLastNameTransfer(
                                resTransferPromtPayByID!.toLastName);
                            ref.read(transferProvider).setToIdentificationID(
                                resTransferPromtPayByID!.toIdentificationID);
                            ref.read(transferProvider).setTimestampTransfer(
                                resTransferPromtPayByID!.timestamp);

                            final totalAmount =
                                ref.watch(transferProvider).amountTransfer +
                                    ref.watch(transferProvider).feeTransfer;
                            ref
                                .read(accountProvider)
                                .setBalanceSelect(balance - totalAmount);
                            print(ref.watch(accountProvider).totalBalance);
                            ref.read(checkPage).setIsErrorPageTransfer(false);
                            await Navigator.pushNamed(context, '/TransferSlip');
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
      ),
    );
  }
}
