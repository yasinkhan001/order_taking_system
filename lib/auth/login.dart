import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taking_system/auth/register.dart';
import 'package:order_taking_system/Screens/user/items_list_user_side.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.isAdmin = false}) : super(key: key);
  final bool isAdmin;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // String? _chairCount;
  // String phoneNumber = '+92334 50 50 505';
  // PhoneNumber number = PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber);
  // String parsableNumber = number.parseNumber();
  // `controller reference`.text = parsableNumber
  final TextEditingController waiterPhoneNumber = TextEditingController();
  final TextEditingController waiterName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController desc = TextEditingController();

  XFile? img;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("LOGIN"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: email,
                        // obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter Email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: pass,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter Password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                        // style: ElevatedButton.styleFrom(primary: Colors.pink),
                        // textColor: Colors.white,
                        // color: Colors.blue,

                        child: const Text('Login'),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await saveText();
                            // Navigator.pushAndRemoveUntil(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ItemsListUserSide()),
                            //         (route) => false);
                          }
                        },
                      ),
                    ),
                    !widget.isAdmin
                        ? Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account? "),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Registration()));
                                  },
                                  child: const Text("REGISTER"),
                                ),
                              ],
                            ))
                        : Container(),
                  ],
                )),
          ),
        ));
  }

  Future<bool?> saveText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('chair', chaircount);
    // prefs.setString('Desc', desc);
    // prefs.setString('status', status);

    // await ServiceController()
    //     .uploadPhoto(
    //         path: img?.path,
    //         name: '${Random().nextInt(500000)}',
    //         extension: img?.path.split('.').last)
    //     .then((imgUrl) async {
    //   FirebaseFirestore.instance
    //       .collection('tables')
    //       .add(myTable.copyWith(img: imgUrl).toMap())
    //       .then((value) async {
    //     FirebaseFirestore.instance
    //         .collection('tables')
    //         .doc(value.id)
    //         .update({'id': value.id});
    //     DocumentSnapshot<Map<String, dynamic>> ym = await FirebaseFirestore
    //         .instance
    //         .collection('tables')
    //         .doc(value.id)
    //         .get();
    //     // OrderTable.fromJson(ym)
    //     prefs.setString('table', jsonEncode(ym.data()));
    //   });
    // });

    // Order order = Order(
    //   orderTable: OrderTable(
    //       id: ' ',
    //       descriptions: 'desc',
    //       tableChairsCount: 1,
    //       status: 'Pending'),
    // ).toJson();
    //Here we'll save our text
  }

// Future<String?> getText() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.getString('OurText');
//   return prefs.getString('Desc');
// }
}

// class PhoneNumber {
//   PhoneNumber.getRegionInfoFromPhoneNumber(String phoneNumber,
//       [String? isoCode]);
//
//   String? parseNumber() {}
// }
