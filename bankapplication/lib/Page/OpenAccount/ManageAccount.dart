import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Models/Account_Models.dart';
import 'package:bankapplication/Models/Response_Option_Models.dart';
import 'package:bankapplication/Page/ListAccount.dart';
import 'package:bankapplication/Page/Login.dart';
import 'package:bankapplication/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final apiNewAccount =
    FutureProvider.autoDispose<List<AcountModels>>((ref) async {
  List<AcountModels> dataAccount =
      await getAccount(ref.watch(loginProvider).userID);
  ref.read(accountProvider).setAccountList(dataAccount);

  print(ref.watch(accountProvider).accountList.length);
  return dataAccount;
});

class ManageAccount extends ConsumerWidget {
  final String title = "จัดการบัญชี";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(apiNewAccount).when(
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
                        child: Text("เปิดบัญชี",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      )),
                  onTap: () async {
                    await Navigator.pushNamed(context, '/OpenAccount');
                  }),
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
                        child: Text("สลับบัญชี",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      )),
                  onTap: () async {
                    await Navigator.pushNamed(context, '/SelectAccount');
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
