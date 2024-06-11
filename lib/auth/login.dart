import 'package:flutter/material.dart';
import 'package:order_taking_system/Controllers/auth_services.dart';
import 'package:order_taking_system/Screens/common/app_colors.dart';
import 'package:order_taking_system/auth/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.isAdmin = false}) : super(key: key);
  final bool isAdmin;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // appBar: AppBar(
        //   title: const Text("LOGIN"),
        // ),
        body: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          color: const Color(0xdc080c52),
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/mutton.jpg'),
                        radius: 60,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "WELCOME",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      Text("BACK",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white)),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      style: inputFieldTextColor,
                      controller: email,
                      // obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                              borderSide: BorderSide(color: Color(0xF8FFC313))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      style: inputFieldTextColor,
                      controller: pass,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.key,
                          color: Colors.white,
                        ),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.all(
                        //       Radius.circular(40),
                        //     ),
                        //     borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                            borderSide: BorderSide(color: Color(0xF8FFC313))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  isLoading
                      ? const SizedBox(
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 180,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    // primary: Color(0xF8FFC313),
                                    shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0xdc080c52)),
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await AuthServices().login(context,
                                          email: email.text,
                                          password: pass.text);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 50,
                  ),
                  !widget.isAdmin
                      ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Registration()));
                                },
                                child: const Text(
                                  "REGISTER",
                                  style: TextStyle(
                                    color: const Color(0xF8FFC313),
                                  ),
                                ),
                              ),
                            ],
                          ))
                      : Container(
                          color: const Color(0xdc080c52),
                        ),
                ],
              )),
        ),
      ),
    ));
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
