import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Models/ATM_Models.dart';
import 'package:bankapplication/Models/Response_Option_Models.dart';
import 'package:bankapplication/Page/ListAccount.dart';
import 'package:bankapplication/Provider/ATMProvider.dart';
import 'package:bankapplication/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getATMProvider =
    ChangeNotifierProvider.autoDispose<ATMProvider>((ref) => ATMProvider());

final apiATM = FutureProvider.autoDispose<List<ATMModels>>((ref) async {
  List<ATMModels> dataATM = await getAtmByAccounNumber(
      ref.watch(accountProvider).accountNumberSelect);
  print(dataATM);
  if (dataATM.isEmpty) {
    ref.read(getATMProvider).setAtm([]);
    ref.read(getATMProvider).setSsHaveATM(false);
  } else {
    ref.read(getATMProvider).setAtm(dataATM);
    ref.read(getATMProvider).setSsHaveATM(true);
  }

  return dataATM;
});

class ManageATM extends ConsumerWidget {
  final String title = "จัดการบัญชี";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lengthATM = ref.watch(getATMProvider).atm.length;
    return ref.watch(apiATM).when(
        error: (error, stackTrace) => Text(stackTrace.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
          if (ref.watch(getATMProvider).atm.isEmpty ||
              ref.watch(getATMProvider).atm[lengthATM - 1].accountAtmStatus ==
                  "CLOSE" ||
              ref.watch(getATMProvider).isHaveATM == false) {
            return Scaffold(
              body: ListView(
                children: [
                  SizedBox(height: 60, child: HeadAccount(title)),
                  SizedBox(height: 520, child: OptionNotATM()),
                ],
              ),
            );
          } else if (ref.watch(getATMProvider).atm.isNotEmpty ||
              ref.watch(getATMProvider).atm[lengthATM - 1].accountAtmStatus ==
                  "ACTIVE" ||
              ref.watch(getATMProvider).isHaveATM == true) {
            ref.read(getATMProvider).setAccountAtmNumber(
                ref.watch(getATMProvider).atm[lengthATM - 1].accountAtmNumber);
            return Scaffold(
              body: ListView(
                children: [
                  SizedBox(height: 60, child: HeadAccount(title)),
                  SizedBox(height: 520, child: OptionHaveATM()),
                ],
              ),
            );
          }
          return Container();
        });
  }
}

class OptionHaveATM extends ConsumerWidget {
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
                      child: Text("ดูข้อมูลบัตร",
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    )),
                onTap: () => Navigator.pushNamed(context, '/DetailATM'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionNotATM extends ConsumerWidget {
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
                        child: Text("สมัครบัตร",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      )),
                  onTap: () {
                    if (ref.watch(accountProvider).accountType == "ฝากประจำ ") {
                      const SnackBarLogin = SnackBar(
                        content: Text("บัญชีฝากประจำไม่สามารถสมัครบัตร ATM ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBarLogin);
                    } else {
                      Navigator.pushNamed(context, '/CreateATM');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
