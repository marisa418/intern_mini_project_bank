import 'package:bankapplication/Page/ATM/CreateATM.dart';
import 'package:bankapplication/Page/ATM/DetailATM.dart';
import 'package:bankapplication/Page/Account/Account.dart';
import 'package:bankapplication/Page/Account/Options.dart/Statement.dart';
import 'package:bankapplication/Page/Account/Options.dart/Transfer/Transfer.dart';
import 'package:bankapplication/Page/Account/Options.dart/Transfer/TransferSlip.dart';
import 'package:bankapplication/Page/Account/Options.dart/Withdraw.dart';
import 'package:bankapplication/Page/Account/Options.dart/deposit.dart';
import 'package:bankapplication/Page/Home.dart';
import 'package:bankapplication/Page/ListAccount.dart';
import 'package:bankapplication/Page/Login.dart';
import 'package:bankapplication/Page/OpenAccount/OpenAccount.dart';
import 'package:bankapplication/Page/PageTest.dart';
import 'package:bankapplication/Page/Register.dart';
import 'package:bankapplication/Page/Setting/PromtPay/CreatePromtPay.dart';
import 'package:bankapplication/Page/Setting/PromtPay/PromtPay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/Test': (context) => Test(),
        '/Login': (context) => Login(),
        '/Register': (context) => Register(),
        '/Home': (context) => Home(),
        '/SelectAccount': (context) => SelectAccount(),
        '/Account': (context) => Account(),
        '/Deposit': (context) => Deposit(),
        '/Transfer': (context) => Transfer(),
        '/TransferSlip': (context) => TransferSlip(),
        '/Withdraw': (context) => Withdraw(),
        '/StateMent': (context) => StateMent(),
        '/OpenAccount': (context) => OpenAccount(),
        '/CreateATM': (context) => CreateATM(),
        '/DetailATM': (context) => DetailATM(),
        '/PromtPay': (context) => PromtPay(),
        '/CreatePromtPay': (context) => CreatePromtPay(),
      },
      initialRoute: "/Login",
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            color: const Color.fromARGB(255, 87, 76, 80),
          ),
          Container(
            height: 674,
            color: Colors.pink,
          ),
        ],
      ),
    );
  }
}
