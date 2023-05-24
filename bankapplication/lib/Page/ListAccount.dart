import 'dart:convert';

import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Models/Account_Models.dart';
import 'package:bankapplication/Page/Home.dart';
import 'package:bankapplication/Page/Login.dart';
import 'package:bankapplication/Provider/AccountProviser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final accountProvider = ChangeNotifierProvider.autoDispose<AccountProvider>(
    (ref) => AccountProvider());

final apiAccount = FutureProvider.autoDispose<List<AcountModels>>((ref) async {
  print("yyyyy");
  print(ref.watch(loginProvider).userID);
  List<AcountModels> dataAccount =
      await getAccount(ref.watch(loginProvider).userID);
  print(dataAccount);
  ref.read(accountProvider).setAccountList(dataAccount);
  // print(json.encode(await ref.watch(loginProvider)));
  print(ref.watch(loginProvider).userID);
  print(ref.watch(loginProvider).userID);

  return dataAccount;
});

class SelectAccount extends ConsumerWidget {
  final String title = "เลือกบัญชีการใช้งาน";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(ref.watch(accountProvider).accountList.length);
    return ref.watch(apiAccount).when(
        error: (error, stackTrace) => Text(stackTrace.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
          return Column(
            children: [
              SizedBox(height: 100, child: _HeadRegister(title)),
              SizedBox(height: 670, child: _ListAccount()),
            ],
          );
        });
  }
}

class _HeadRegister extends ConsumerWidget {
  const _HeadRegister(
    this.title, {
    Key? key,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String totalBalance =
        ref.watch(accountProvider).totalBalance.toString();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: 100,
        child: Text(
          title,
          style: const TextStyle(fontSize: 25, color: Color(0xff49A9A0)),
        ),
      ),
    );
  }
}

class _ListAccount extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lengthOfAccount = ref.watch(accountProvider).accountList.length;
    return ref.watch(apiAccount).when(
        error: (error, stackTrace) => Text(stackTrace.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
          return Scaffold(
              body: ListView.builder(
                  itemCount: lengthOfAccount,
                  itemBuilder: (context, index) {
                    final accountList =
                        ref.watch(accountProvider).accountList[index];

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: InkWell(
                        child: Card(
                          color: Color(0xff49A9A0),
                          elevation: 10,
                          shadowColor: Colors.black.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: SizedBox(
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 10, right: 15),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            accountList.accountNumber
                                                .replaceRange(
                                                    2, 9, "X-X-XXXXX-"),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white)),
                                        Text(accountList.accountType,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    const Text("ยอดคงเหลือ (บาท) ",
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(accountList.balance.toString(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ],
                                ),
                              )),
                        ),
                        onTap: () {
                          ref.read(accountProvider).setAccountNumberSelect(
                              accountList.accountNumber);
                          ref
                              .read(accountProvider)
                              .setBalanceSelect(accountList.balance);
                          ref
                              .read(accountProvider)
                              .setAccountType(accountList.accountType);
                          ref.read(checkPage).setCheckPageinHome("Account");
                          Navigator.pushNamed(context, '/Home');
                        },
                      ),
                    );
                  }));
        });
  }
}
