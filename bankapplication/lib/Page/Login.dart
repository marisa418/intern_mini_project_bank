import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Models/User_Models.dart';
import 'package:bankapplication/Provider/UsersProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final loginProvider =
    ChangeNotifierProvider.autoDispose<UsersProvider>((ref) => UsersProvider());

class Login extends ConsumerWidget {
  var keyLogin = GlobalKey<FormState>();
  TextEditingController passWordController = TextEditingController();
  TextEditingController identificationID = TextEditingController();

  var userDetail;

  //List<UserModels> userDetail = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String identificationIDLogin = identificationID.text;
    final String passwordLogin = passWordController.text;
    return Scaffold(
      body: ListView(
        children: [
          _HeadLogin(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: keyLogin,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length < 13) {
                            return 'เลขบัตรประชาชนต้องมี 13 หลัก';
                          }
                          return null;
                        },
                        controller: identificationID,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(13),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          contentPadding: const EdgeInsets.all(6),
                          labelText: 'เลขประจำตัวประชาชน',
                          border: InputBorder.none,
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        onChanged: (e) {
                          ref
                              .read(loginProvider)
                              .setidentificationIDLogin(identificationIDLogin);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: passWordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          labelText: 'รหัสผ่าน',
                          border: InputBorder.none,
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        onChanged: (e) {
                          ref.read(loginProvider).setPasswordLogin(e);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Container(
                      width: 380,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xff49A9A0),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: FlatButton(
                        child: const Text(
                          "เข้าสู่ระบบ",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        onPressed: () async {
                          ref
                              .read(loginProvider)
                              .setUserID(identificationID.text);
                          ref
                              .read(loginProvider)
                              .setPasswordLogin(passWordController.text);
                          http.Response responseLogin = await LoginUser(
                              identificationID.text, passWordController.text);

                          print(responseLogin.statusCode);
                          if (responseLogin.statusCode == 200) {
                            userDetail = UserModels.fromJson(
                                jsonDecode(responseLogin.body));

                            ref.read(loginProvider).setUser(userDetail);
                            ref
                                .read(loginProvider)
                                .setUserID(userDetail.userID);

                            print(ref.watch(loginProvider).userID);
                            print(ref.watch(loginProvider).userID);
                            ref
                                .read(loginProvider)
                                .setFirstName(userDetail.firstName);
                            ref
                                .read(loginProvider)
                                .setLastName(userDetail.lastName);
                            ref.read(loginProvider).setidentificationIDLogin(
                                userDetail.identificationID);
                            ref
                                .read(loginProvider)
                                .setPrefix(userDetail.prefix);

                            Navigator.pushNamed(context, '/SelectAccount');
                          } else {
                            const SnackBarLogin = SnackBar(
                              content: Text("ข้อมูลไม่ถูกต้อง",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20)),
                              duration: Duration(seconds: 1),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBarLogin);
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          "ลงทะเบียนใช้งาน",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff49A9A0)),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/Register');
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeadLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
    );
  }
}
