import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Models/PromtPay_Models.dart';
import 'package:bankapplication/Models/Response_Option_Models.dart';
import 'package:bankapplication/Page/ListAccount.dart';
import 'package:bankapplication/Page/Login.dart';
import 'package:bankapplication/Provider/PromtPayProvider.dart';
import 'package:bankapplication/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final promtPayProvider = ChangeNotifierProvider.autoDispose<PromtPayProvider>(
    (ref) => PromtPayProvider());

final apiAccountPromtpayt =
    FutureProvider.autoDispose<List<PromtPayModels>>((ref) async {
  List<PromtPayModels> dataAccountPromtpayt =
      await getAccountPromptPay(ref.watch(accountProvider).accountNumberSelect);
  ref.read(promtPayProvider).setAccountPromtpayt(dataAccountPromtpayt);
  print(dataAccountPromtpayt);
  print(ref.watch(promtPayProvider).accountPromtpay.length);
  return dataAccountPromtpayt;
});

class Setting extends ConsumerWidget {
  final String title = "ตั้งค่า";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(apiAccountPromtpayt).when(
        error: (error, stackTrace) => Text(stackTrace.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
          return Scaffold(
            body: ListView(
              children: [
                SizedBox(height: 60, child: HeadAccount(title)),
                SizedBox(height: 520, child: Option()),
              ],
            ),
          );
        });
  }
}

class Option extends ConsumerWidget {
  TextEditingController amountController = TextEditingController();

  UpdateBalance? endBalance;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                child: Container(
                    alignment: Alignment.bottomLeft,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black, width: 1.0))),
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text("ออกจากระบบ",
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    )),
                onTap: () => Navigator.pushNamed(context, '/Login'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                  child: Container(
                      alignment: Alignment.bottomLeft,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 1.0))),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text("พร้อมเพย์ ",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      )),
                  onTap: () {
                    if (ref.watch(accountProvider).accountType == "ฝากประจำ ") {
                      const SnackBarLogin = SnackBar(
                        content: Text("บัญชีฝากประจำไม่สามารถใช้พร้อมเพย์",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBarLogin);
                    } else {
                      Navigator.pushNamed(context, '/PromtPay');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
