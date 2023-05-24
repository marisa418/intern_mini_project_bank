import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Models/History_Statement_Models.dart';
import 'package:bankapplication/Page/ListAccount.dart';
import 'package:bankapplication/Page/Login.dart';
import 'package:bankapplication/Provider/HistoryStatementProvider.dart';
import 'package:bankapplication/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final historyProvider =
    ChangeNotifierProvider.autoDispose<HistoryStatementProvider>(
        (ref) => HistoryStatementProvider());

final apiHistoryStatement =
    FutureProvider.autoDispose<List<HistoryStatementModels>>((ref) async {
  List<HistoryStatementModels> dataHistory = await getHistoryStatementModels(
      ref.watch(accountProvider).accountNumberSelect);
  ref.read(historyProvider).setHistoryStatement(dataHistory);
  print(ref.watch(historyProvider).historyStatement.length);
  return dataHistory;
});

class Account extends ConsumerWidget {
  final String title = "บัญชีเงินฝาก";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        // reverse: true,
        children: [
          SizedBox(height: 60, child: HeadAccount(title)),
          SizedBox(height: 120, child: DetailAccount()),
          SizedBox(height: 100, child: _OptionAccount()),
          SizedBox(height: 390, child: StateAccount()),
        ],
      ),
    );
  }
}

class DetailAccount extends ConsumerWidget {
  const DetailAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String firstName = ref.watch(loginProvider).firstName;
    final String lastName = ref.watch(loginProvider).lastName;
    final String accountNumber = ref.watch(accountProvider).accountNumberSelect;
    final double balance = ref.watch(accountProvider).balanceSelect;
    final String accountType = ref.watch(accountProvider).accountType;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Color(0xff49A9A0),
          border: Border.all(
            color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        firstName + "  " + lastName,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        accountType,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Text(
                  accountNumber.replaceRange(2, 9, "X-X-XXXXX-"),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "ยอดเงินคงเหลือ (บาท)",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  balance.toStringAsFixed(2),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class _OptionAccount extends ConsumerWidget {
  const _OptionAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xff49A9A0),
          border: Border.all(
            color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
            width: 1,
          ),
          borderRadius: new BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/Transfer');
                  },
                  child: SizedBox(
                    child: Column(
                      children: const [
                        Icon(
                          IconData(0xf53b, fontFamily: 'MaterialIcons'),
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(
                          "โอนเงิน",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/Deposit');
                  },
                  child: SizedBox(
                    child: Column(
                      children: const [
                        Icon(
                          IconData(0xf8d2, fontFamily: 'MaterialIcons'),
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(
                          "ฝากเงิน",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/Withdraw');
                  },
                  child: SizedBox(
                    child: Column(
                      children: const [
                        Icon(
                          IconData(0xf04dc, fontFamily: 'MaterialIcons'),
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(
                          "ถอนเงิน",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: SizedBox(
              //       child: Column(
              //         children: const [
              //           Icon(
              //             IconData(0xe50d, fontFamily: 'MaterialIcons'),
              //             size: 40,
              //             color: Colors.white,
              //           ),
              //           Text(
              //             "Statement",
              //             style: TextStyle(
              //               fontSize: 16,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ));
  }
}

class StateAccount extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String checkThisNamePage =
        ref.watch(accountProvider).checkpageStatement;

    return Scaffold(
        body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Text(
                "รายการรับเข้า",
                style: TextStyle(
                    fontSize: 20,
                    color: checkThisNamePage != "AdmissionList"
                        ? Colors.black
                        : Colors.blue),
              ),
              onTap: () {
                ref
                    .read(accountProvider)
                    .setCheckpageStatement("AdmissionList");
              },
            ),
            const SizedBox(
              width: 60,
            ),
            InkWell(
              child: Text(
                "รายการส่งออก",
                style: TextStyle(
                    fontSize: 20,
                    color: checkThisNamePage != "ExportList"
                        ? Colors.black
                        : Colors.blue),
              ),
              onTap: () {
                ref.read(accountProvider).setCheckpageStatement("ExportList");
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: _ShowStateList(checkThisNamePage),
        ),
      ],
    ));
  }
}

class _ShowStateList extends ConsumerWidget {
  _ShowStateList(
    this.checkThisNamePage, {
    Key? key,
  }) : super(key: key);
  final String checkThisNamePage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (checkThisNamePage == "AdmissionList") {
      return _AdmissionList();
    } else {
      return _ExportList();
    }
  }
}

class _AdmissionList extends ConsumerWidget {
  const _AdmissionList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(apiHistoryStatement).when(
        error: (error, stackTrace) => Text(stackTrace.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
          return Card(
            elevation: 10,
            shadowColor: Colors.black.withOpacity(0.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              height: 340,
              child: Align(
                alignment: Alignment.topLeft,
                child: ListView.builder(
                    itemCount:
                        ref.watch(historyProvider).historyStatement.length,
                    itemBuilder: (context, index) {
                      final historyStateList =
                          ref.watch(historyProvider).historyStatement[index];
                      if (historyStateList.accountNumber !=
                          ref.watch(accountProvider).accountNumberSelect) {
                        if (historyStateList.toAccount != "Null") {
                          return StatusaddTransfer(historyStateList);
                        }
                      }

                      if (historyStateList.action == "OPEN" ||
                          historyStateList.action == "DEPOSIT") {
                        return StatusDeposit(historyStateList);
                      }
                      if (historyStateList.action == "INTEREST") {
                        return StatusINTEREST(historyStateList);
                      }

                      return Container();
                    }),
              ),
            ),
          );
        });
  }
}

class _ExportList extends ConsumerWidget {
  const _ExportList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(apiHistoryStatement).when(
        error: (error, stackTrace) => Text(stackTrace.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
          final lengthList = ref.watch(historyProvider).historyStatement.length;

          return Card(
            elevation: 10,
            shadowColor: Colors.black.withOpacity(0.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              height: 340,
              child: Align(
                alignment: Alignment.topLeft,
                child: ListView.builder(
                    itemCount: lengthList,
                    itemBuilder: (context, index) {
                      final historyStateList =
                          ref.watch(historyProvider).historyStatement[index];

                      if (historyStateList.action == "TRANSFER") {
                        if (historyStateList.toAccount !=
                                ref
                                    .watch(accountProvider)
                                    .accountNumberSelect &&
                            historyStateList.toAccount != "Null") {
                          return StatusExportTransfer(historyStateList);
                        }
                      }
                      if (historyStateList.action == "WITHDRAW") {
                        return StatusWITHDRAW(historyStateList);
                      }

                      return Container();
                    }),
              ),
            ),
          );
        });
  }
}

class AccountMenu extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: SizedBox(
                  child: Column(
                    children: [
                      Icon(
                        IconData(0xe041, fontFamily: 'MaterialIcons'),
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        "โอนเงิน",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: SizedBox(
                  child: Column(
                    children: [
                      Icon(
                        IconData(0xe041, fontFamily: 'MaterialIcons'),
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        "โอนเงิน",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: SizedBox(
                  child: Column(
                    children: [
                      Icon(
                        IconData(0xe041, fontFamily: 'MaterialIcons'),
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        "โอนเงิน",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: SizedBox(
                  child: Column(
                    children: [
                      Icon(
                        IconData(0xe041, fontFamily: 'MaterialIcons'),
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        "โอนเงิน",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusaddTransfer extends ConsumerWidget {
  StatusaddTransfer(this.historyStateList, {Key? key}) : super(key: key);
  late HistoryStatementModels historyStateList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        )),
        child: ExpansionTile(
          title: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "โอนเงินเข้า",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    DateFormat.yMMMEd().format(historyStateList.timestamp),
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 84, 84, 84)),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            "+ " + historyStateList.total.toString(),
            style: TextStyle(fontSize: 16, color: Colors.blue),
            textAlign: TextAlign.end,
          ),
          children: <Widget>[
            ListTile(
                title: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "จากเลขที่บัญชี",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      historyStateList.accountNumber
                          .replaceRange(2, 9, "X-X-XXXXX-"),
                      style: TextStyle(
                          fontSize: 14, color: Color.fromARGB(255, 84, 84, 84)),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class StatusDeposit extends ConsumerWidget {
  StatusDeposit(this.historyStateList, {Key? key}) : super(key: key);
  late HistoryStatementModels historyStateList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(historyStateList);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        )),
        child: ExpansionTile(
          title: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    historyStateList.action == "DEPOSIT"
                        ? "ฝากเงิน"
                        : historyStateList.action == "OPEN"
                            ? "เปิดบัญชี"
                            : "",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    DateFormat.yMMMEd().format(historyStateList.timestamp),
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 84, 84, 84)),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            "+ " + historyStateList.total.toString(),
            style: TextStyle(fontSize: 16, color: Colors.blue),
            textAlign: TextAlign.end,
          ),
          children: <Widget>[
            ListTile(
                title: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "ช่องทาง",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: const Text(
                      "เงินสด",
                      style: TextStyle(
                          fontSize: 14, color: Color.fromARGB(255, 84, 84, 84)),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class StatusExportTransfer extends ConsumerWidget {
  StatusExportTransfer(this.historyStateList, {Key? key}) : super(key: key);
  late HistoryStatementModels historyStateList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        )),
        child: ExpansionTile(
          title: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "โอนเงินออก",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    DateFormat.yMMMEd().format(historyStateList.timestamp),
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 84, 84, 84)),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            "- " + historyStateList.total.toString(),
            style: TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.end,
          ),
          children: <Widget>[
            ListTile(
                title: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "ไปยังเลขที่บัญชี",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          historyStateList.toAccount
                              .replaceRange(2, 9, "X-X-XXXXX-"),
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 84, 84, 84)),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "ชื่อบัญชี",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          historyStateList.toFirstName +
                              " " +
                              historyStateList.toLastName,
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 84, 84, 84)),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class StatusWITHDRAW extends ConsumerWidget {
  StatusWITHDRAW(this.historyStateList, {Key? key}) : super(key: key);
  late HistoryStatementModels historyStateList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        )),
        child: ExpansionTile(
          title: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "ถอนเงิน",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    DateFormat.yMMMEd().format(historyStateList.timestamp),
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 84, 84, 84)),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            "- " + historyStateList.total.toString(),
            style: TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.end,
          ),
          children: <Widget>[
            ListTile(
                title: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "ช่องทาง",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          "เงินสด",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 84, 84, 84)),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class StatusINTEREST extends ConsumerWidget {
  StatusINTEREST(this.historyStateList, {Key? key}) : super(key: key);
  late HistoryStatementModels historyStateList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        )),
        child: ExpansionTile(
          title: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "ดอกเบี้ย",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    DateFormat.yMMMEd().format(historyStateList.timestamp),
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 84, 84, 84)),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            "+ " + historyStateList.total.toStringAsFixed(2),
            style: TextStyle(fontSize: 16, color: Colors.blue),
            textAlign: TextAlign.end,
          ),
          children: <Widget>[
            ListTile(
                title: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "จาก",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          "EABank",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 84, 84, 84)),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
