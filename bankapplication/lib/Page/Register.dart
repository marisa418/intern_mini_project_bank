import 'package:bankapplication/Api/Api.dart';
import 'package:bankapplication/Page/Login.dart';
import 'package:bankapplication/Provider/RegisterProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final regis = ChangeNotifierProvider.autoDispose<RegisterProvider>(
    (ref) => RegisterProvider());

class Register extends ConsumerWidget {
  TextEditingController passWordController = TextEditingController();
  TextEditingController conPassWordController = TextEditingController();
  TextEditingController identificationID = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  List<String> typeSex = ["Mr", "Mrs", "Miss"];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefix = ref.watch(regis).prefix;
    final validatePrefix = ref.watch(regis).validatePrefix;
    return Scaffold(
      body: ListView(
        children: [
          _HeadRegister(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
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
                        controller: identificationID,
                        validator: (identificationID) {
                          if (identificationID!.isEmpty) {
                            return 'กรุณาใส่ข้อมูล';
                          } else if (identificationID.length < 13) {
                            return 'เลขบัตรประชาชนต้องมี 13 หลัก';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(13),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          labelText: 'Identification ID',
                          border: InputBorder.none,
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 44, left: 5),
                              child: Text(
                                "กรุณาใส่ข้อมูล",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: validatePrefix == false
                                        ? Colors.white
                                        : Color(0xFFD43232)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 120,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(255, 44, 44, 44)
                                      .withOpacity(0.2),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    hint: prefix == ""
                                        ? const Text("Sex")
                                        : Text(prefix.toString()),
                                    items: typeSex.map((results) {
                                      return DropdownMenuItem(
                                          child: Text(results), value: results);
                                    }).toList(),
                                    onChanged: (value) {
                                      ref
                                          .read(regis)
                                          .setPrefix(value.toString());
                                      ref.read(regis).setValidatePrefixd(false);
                                    }),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 250,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 44, 44, 44)
                                  .withOpacity(0.2),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: firstNameController,
                            validator: (firstNameController) {
                              return firstNameController!.isEmpty
                                  ? 'กรุณาใส่ข้อมูล'
                                  : null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(3),
                              labelText: 'First Name ',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
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
                        controller: lastNameController,
                        validator: (lastNameController) {
                          return lastNameController!.isEmpty
                              ? 'กรุณาใส่ข้อมูล'
                              : null;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          labelText: 'Last Name',
                          border: InputBorder.none,
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
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
                        validator: (passWordController) {
                          if (passWordController!.isEmpty) {
                            return 'กรุณาป้อนข้อมูล';
                          } else if (isPasswordCompliant(passWordController) ==
                              false) {
                            return 'รหัสผ่านต้องประกอบด้วย ตัวพิมใหญ่ พิมพ์เล็ก และมีความยาวตั้งแต่ 6';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          labelText: 'Password',
                          border: InputBorder.none,
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 44, 44, 44)
                              .withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: conPassWordController,
                        obscureText: true,
                        validator: (conPassWordController) {
                          if (conPassWordController!.isEmpty) {
                            return 'กรุณาป้อนข้อมูล';
                          }
                          if (isPasswordCompliant(conPassWordController) ==
                              false) {
                            return 'รหัสผ่านต้องประกอบด้วย ตัวพิมใหญ่ พิมพ์เล็ก และมีความยาวตั้งแต่ 6';
                          }
                          if (passWordController.text !=
                              conPassWordController) {
                            return 'รหัสผ่านไม่ตรงกัน';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          labelText: 'Confirm Password',
                          border: InputBorder.none,
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "* รหัสผ่านต้องประกอบด้วย ตัวพิมใหญ่ พิมพ์เล็ก และมีความยาวตั้งแต่ 6",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      width: 380,
                      height: 60,
                      decoration: const BoxDecoration(
                          color: Color(0xff49A9A0),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: FlatButton(
                        child: const Text(
                          "ลงทะเบียน",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onPressed: () async {
                          if (prefix == "") {
                            ref.read(regis).setValidatePrefixd(true);
                          }
                          if (formKey.currentState!.validate()) {
                            http.Response responseRegister = await RegisterUser(
                                firstNameController.text,
                                lastNameController.text,
                                identificationID.text,
                                passWordController.text,
                                conPassWordController.text,
                                prefix);
                            print("responseRegister: " +
                                responseRegister.statusCode.toString());
                            if (responseRegister.statusCode == 200) {
                              ref
                                  .read(loginProvider)
                                  .setUserID(responseRegister.body);
                              print("zzzz");
                              print(ref.watch(loginProvider).userID);
                              ref
                                  .read(loginProvider)
                                  .setFirstName(firstNameController.text);
                              ref
                                  .read(loginProvider)
                                  .setLastName(lastNameController.text);
                              ref.read(loginProvider).setidentificationIDLogin(
                                  identificationID.text);
                              ref.read(loginProvider).setPrefix(prefix);

                              Navigator.pushNamed(context, '/SelectAccount');
                            } else {
                              const SnackBarRegister = SnackBar(
                                content: Text("ลงทะเบียนไม่สำเร็จ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20)),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBarRegister);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

bool isPasswordCompliant(String password, [int minLength = 6]) {
  if (password.isEmpty) {
    return false;
  }
  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
  bool hasMinLength = password.length >= minLength;

  return hasDigits & hasUppercase & hasLowercase & hasMinLength;
}

class _HeadRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      child: Text(
        "ลงทะเบียนใช้งาน",
        style: TextStyle(fontSize: 25, color: Color(0xff49A9A0)),
      ),
    );
  }
}
