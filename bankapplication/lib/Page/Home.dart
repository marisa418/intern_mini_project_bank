import 'package:bankapplication/Page/ATM/ManageATM.dart';
import 'package:bankapplication/Page/Account/Account.dart';
import 'package:bankapplication/Page/Account/Options.dart/Transfer/TransferSlip.dart';
import 'package:bankapplication/Page/OpenAccount/ManageAccount.dart';
import 'package:bankapplication/Page/OpenAccount/OpenAccount.dart';
import 'package:bankapplication/Page/Setting/Setting.dart';
import 'package:bankapplication/Provider/CheckPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkPage =
    ChangeNotifierProvider.autoDispose<CheckPage>((ref) => CheckPage());

// class Home extends StatefulWidget {
//   const Home({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<Home> createState() => _Home();
// }

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 670,
            child: ShowPage(),
          ),
          SizedBox(height: 80, child: MainMenu())
        ],
      ),
    );
  }
}

class ShowPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String checkThistMainPage = ref.watch(checkPage).checkPageinHome;
    if (checkThistMainPage == "Account") {
      return Account();
    }
    if (checkThistMainPage == "ATM") {
      return ManageATM();
    }
    if (checkThistMainPage == "NewAccount") {
      return ManageAccount();
    }
    if (checkThistMainPage == "Setting") {
      return Setting();
    }
    return Container();
  }
}
// class _ShowPage extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     is ()
//   }
// }

// class MainMenu extends StatefulWidget {
//   MainMenu({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<MainMenu> createState() => _MainMenu();
// }

class MainMenu extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late String checkThistMainPage = ref.watch(checkPage).checkPageinHome;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ref.read(checkPage).setCheckPageinHome("Account");
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      Icon(
                        IconData(0xe041, fontFamily: 'MaterialIcons'),
                        size: 40,
                        color: checkThistMainPage == "Account"
                            ? Color.fromARGB(255, 0, 0, 250)
                            : Colors.black,
                      ),
                      Text(
                        "บัญชี",
                        style: TextStyle(
                          fontSize: 16,
                          color: checkThistMainPage == "Account"
                              ? Colors.blue
                              : Colors.black,
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
                  ref.read(checkPage).setCheckPageinHome("ATM");
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      Icon(
                        IconData(0xe19f, fontFamily: 'MaterialIcons'),
                        size: 40,
                        color: checkThistMainPage == "ATM"
                            ? Color.fromARGB(255, 0, 0, 250)
                            : Colors.black,
                      ),
                      Text(
                        "ATM",
                        style: TextStyle(
                          fontSize: 16,
                          color: checkThistMainPage == "ATM"
                              ? Colors.blue
                              : Colors.black,
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
                  ref.read(checkPage).setCheckPageinHome("NewAccount");
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      Icon(
                        IconData(0xf04b7, fontFamily: 'MaterialIcons'),
                        size: 40,
                        color: checkThistMainPage == "NewAccount"
                            ? Color.fromARGB(255, 0, 0, 250)
                            : Colors.black,
                      ),
                      Text(
                        "จัดการบัญชี",
                        style: TextStyle(
                          fontSize: 16,
                          color: checkThistMainPage == "NewAccount"
                              ? Colors.blue
                              : Colors.black,
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
                  ref.read(checkPage).setCheckPageinHome("Setting");
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      Icon(
                        IconData(0xec85, fontFamily: 'MaterialIcons'),
                        size: 40,
                        color: checkThistMainPage == "Setting"
                            ? Color.fromARGB(255, 0, 0, 250)
                            : Colors.black,
                      ),
                      Text(
                        "ตั้งค่า",
                        style: TextStyle(
                          fontSize: 16,
                          color: checkThistMainPage == "Setting"
                              ? Colors.blue
                              : Colors.black,
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
