import 'dart:typed_data';

import 'package:bankapplication/Models/Response_Option_Models.dart';
import 'package:bankapplication/Page/ListAccount.dart';
import 'package:bankapplication/Page/Login.dart';
import 'package:bankapplication/Provider/TransferProvider.dart';
import 'package:bankapplication/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

final transferProvider = ChangeNotifierProvider.autoDispose<TransferProvider>(
    (ref) => TransferProvider());

class TransferSlip extends ConsumerWidget {
  ScreenshotController screenshotController = ScreenshotController();
  final String title = "การทำธุรกรรมสำเร็จ";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        // reverse: true,
        children: [
          Screenshot(
            controller: screenshotController,
            child: SizedBox(height: 480, child: DetailSlip()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              alignment: Alignment.center,
              child: InkWell(
                child: Text(
                  'บันทึกสลิป',
                  style: TextStyle(fontSize: 20, color: Color(0xff49A9A0)),
                ),
                onTap: () async {
                  final image = await screenshotController.capture();
                  if (image == null) {
                    const SnackBarLogin = SnackBar(
                      content: Text("บันทึกไม่สำเร็จ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)),
                      duration: Duration(seconds: 3),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBarLogin);
                  } else {
                    await saveImage(image);
                    const SnackBarLogin = SnackBar(
                      content: Text("บันทึกสำเร็จ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)),
                      duration: Duration(seconds: 3),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBarLogin);
                  }
                },
              ),
            ),
          ),
          SizedBox(
            child: Button(),
          ),
        ],
      ),
    );
  }
}

class DetailSlip extends ConsumerWidget {
  OtherTransfer? endBalance;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Card(
        color: Color(0xff49A9A0).withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 15),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "โอนเงินสำเร็จ",
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                              Text(
                                DateFormat.yMMMMd('en_US').add_jm().format(ref
                                    .watch(transferProvider)
                                    .timestampTransfer),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: const Text("EA",
                                style: TextStyle(
                                    fontSize: 60, color: Colors.white)))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white, width: 1.0))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: const Text("จาก",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)))),
                        Expanded(
                            flex: 3,
                            child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                        ref.watch(loginProvider).firstName +
                                            "  " +
                                            ref.watch(loginProvider).lastName,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    Text(
                                      ref
                                          .watch(accountProvider)
                                          .accountNumberSelect
                                          .replaceRange(2, 9, "X-X-XXXXX-"),
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white, width: 1.0))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: const Text("ไปที่",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)))),
                        Expanded(
                            flex: 3,
                            child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                        ref
                                                .watch(transferProvider)
                                                .toFirstNameTransfer +
                                            "  " +
                                            ref
                                                .watch(transferProvider)
                                                .toLastNameTransfer,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    Text(
                                      ref
                                                      .watch(transferProvider)
                                                      .checkTypeTransfer ==
                                                  "PromptPay" &&
                                              ref
                                                      .watch(transferProvider)
                                                      .checkTypePromptPay ==
                                                  "identificationID"
                                          ? ref
                                              .watch(transferProvider)
                                              .toIdentificationID
                                              .replaceRange(
                                                  3, 12, "XX-XX-XXXXX-")
                                          : ref
                                                          .watch(
                                                              transferProvider)
                                                          .checkTypeTransfer ==
                                                      "PromptPay" &&
                                                  ref
                                                          .watch(
                                                              transferProvider)
                                                          .checkTypePromptPay ==
                                                      "PhoneNumber"
                                              ? ref
                                                  .watch(transferProvider)
                                                  .toPhoneNumber
                                                  .replaceRange(
                                                      2, 9, "X-X-XXXXX-")
                                              : ref
                                                  .watch(transferProvider)
                                                  .toAccountTransfer
                                                  .replaceRange(
                                                      2, 9, "X-X-XXXXX-"),
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white, width: 1.0))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                                alignment: Alignment.bottomLeft,
                                child: const Text("เลขที่รายการ",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)))),
                        Expanded(
                            flex: 3,
                            child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  ref
                                      .watch(transferProvider)
                                      .transactionIDTransfer,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ))),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.bottomLeft,
                            child: const Text("จำนวนเงิน",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)))),
                    Expanded(
                        flex: 3,
                        child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              ref
                                      .watch(transferProvider)
                                      .amountTransfer
                                      .toStringAsFixed(2) +
                                  "  บาท",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.bottomLeft,
                            child: const Text("ค่าธรรมเนียม",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)))),
                    Expanded(
                        flex: 3,
                        child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              ref
                                      .watch(transferProvider)
                                      .feeTransfer
                                      .toStringAsFixed(2) +
                                  "  บาท",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Container(
        width: 380,
        height: 60,
        decoration: const BoxDecoration(
            color: Color(0xff49A9A0),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: FlatButton(
            child: const Text(
              "เสร็จสิ้น",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            onPressed: () => Navigator.pushNamed(context, '/Home')),
      ),
    );
  }
}

Future<String> saveImage(Uint8List capturedImage) async {
  await [Permission.storage].request();
  final time = DateTime.now()
      .toIso8601String()
      .replaceAll('.', '-')
      .replaceAll(':', '-');
  final name = 'screenshot_$time';
  final result = await ImageGallerySaver.saveImage(capturedImage, name: name);
  return result["filePath"];
}
