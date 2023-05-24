import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Page/ATM/ManageATM.dart';
import 'package:bankapplication/Page/Login.dart';
import 'package:bankapplication/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class DetailATM extends ConsumerWidget {
  final String title = "รายละเอียดบัตร";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 60, child: HeadAccountOption(title)),
          SizedBox(height: 150, child: Detail()),
          SizedBox(height: 80, child: CloseATM()),
        ],
      ),
    );
  }
}

class Detail extends ConsumerWidget {
  Detail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String firstName = ref.watch(loginProvider).firstName;
    final String lastName = ref.watch(loginProvider).lastName;
    final String accountAtmNumber = ref.watch(getATMProvider).accountAtmNumber;
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      firstName + "  " + lastName,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    accountAtmNumber.replaceRange(4, 11, "X-X-XXXXX-"),
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class CloseATM extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: InkWell(
          child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color(0xff49A9A0),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text("ระงับบัตร",
                  style: TextStyle(fontSize: 25, color: Colors.white))),
          onTap: () {
            showPlatformDialog(
              context: context,
              builder: (context) => BasicDialogAlert(
                title: Text("ท่านกำลังทำการปิดการใช้งานบัตรATM"),
                content: Text("ต้องการปิดการใช้งานเลยหรือไม่"),
                actions: <Widget>[
                  BasicDialogAction(
                    title: Text("ตกลง"),
                    onPressed: () async {
                      http.Response responseCloseATM = await SendCloseATM(
                          ref.watch(getATMProvider).accountAtmNumber);
                      ref.read(getATMProvider).setSsHaveATM(false);

                      await Navigator.pushNamed(context, '/Home');
                    },
                  ),
                  BasicDialogAction(
                    title: Text("ไม่"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
