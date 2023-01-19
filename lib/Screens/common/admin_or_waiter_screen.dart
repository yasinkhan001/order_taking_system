import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/auth/login.dart';

class AdminOrWaiter extends StatefulWidget {
  const AdminOrWaiter({Key? key}) : super(key: key);

  @override
  State<AdminOrWaiter> createState() => _AdminOrWaiterState();
}

class _AdminOrWaiterState extends State<AdminOrWaiter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: EdgeInsets.only(top: 120),
        constraints: const BoxConstraints.expand(),
        color: const Color(0xfcffffff),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 120),
              child: BounceInDown(
                  duration: const Duration(seconds: 4),
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black45,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            color: Color(0x9a868585),
                          ),
                        ]),
                    padding: const EdgeInsets.all(0),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/mutton.jpg'),
                      radius: 110,
                    ),
                  )),
            ),
            // OutlinedButton(
            //   style: OutlinedButton.styleFrom(
            //     backgroundColor: Colors.white12,
            //     primary: Colors.white,
            //
            //     elevation: 20, //<-- SEE HERE
            //     shadowColor: Colors.red[10], //<-- SEE HERE
            //   ),
            //   onPressed: () {},
            //   child: const Text(
            //     'Admin',
            //     style: TextStyle(fontSize: 20),
            //   ),
            // )
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: AnimatedTextKit(
                // repeatForever: true,
                // isRepeatingAnimation: true,
                animatedTexts: [
                  TyperAnimatedText(
                    "Nisar Restaurant",
                    speed: const Duration(microseconds: 100000),
                    textStyle: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 38,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            color: Color(0x9a868585),
                          ),
                        ]),
                  )
                ],
                onTap: () {},
              ),
              // child: Text(
              //   "Who you are ?",
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 26),
              // ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: SizedBox(
                width: 180,
                // height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black45, //background color of button
                        side: const BorderSide(
                            width: 1,
                            color: Colors.blue), //border width and color
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(20)),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen(
                                    isAdmin: true,
                                  )));
                    },
                    child: const Center(child: Text('Admin'))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 180,
                // height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black45, //background color of button
                        side: const BorderSide(
                            width: 1,
                            color: Colors.blue), //border width and color
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(20)),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen(
                                    isAdmin: false,
                                  )));
                    },
                    child: const Center(child: Text('Waiter'))),
              ),
            ),
            // const SizedBox(
            //   height: 10,
            //   width: 100,
            // ),

            // backgroundColor: Colors.lightBlue[50],
          ],
        ),
      ),
    );
  }
}
