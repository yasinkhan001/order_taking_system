import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:order_taking_system/Models/user_model.dart';
import 'package:order_taking_system/Screens/admin/admin_dashboard.dart';
import 'package:order_taking_system/Screens/common/admin_or_waiter_screen.dart';
import 'package:order_taking_system/Screens/user/items_list_user_side.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  dynamic key;
  // required Widget child;
  Duration duration = const Duration(milliseconds: 800);
  Duration delay = const Duration(milliseconds: 0);
  dynamic Function(AnimationController)? controller;
  bool manualTrigger = false;
  bool animate = true;
  double from = 100;
  @override
  initState() {
    super.initState();

    init();
  }

  init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey('user')) {
      String? tbl = preferences.getString('user');
      Map<String, dynamic> mp = jsonDecode(tbl!);
      AppUser appUser = AppUser.fromMap(mp);
      if (appUser.isAdmin!) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AdminDashboard()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ItemsListUserSide()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: const Color(0xfffcfcfc),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // mainAxisAlignment: MainAxisAlignment.s,
          // crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            BounceInDown(
                duration: const Duration(seconds: 4),
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/tikka.jpeg'),
                  radius: 110,
                )),
            // const CircleAvatar(
            //   backgroundImage: AssetImage('assets/tikka.jpeg'),
            //   radius: 110,
            // ),
            Column(
              children: [
                // Text(
                //   "Nisar Tikka",
                //   style: TextStyle(
                //       color: Colors.green,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 38,
                //       shadows: <Shadow>[
                //         Shadow(
                //           offset: Offset(4.0, 4.0),
                //           blurRadius: 15.0,
                //           color: Color.fromARGB(255, 61, 60, 60),
                //         ),
                //       ]),
                // ),
                AnimatedTextKit(
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
                              color: Color.fromARGB(255, 61, 60, 60),
                            ),
                          ]),
                    )
                  ],
                  onTap: () {},
                ),
                const Text(
                  "A very famous restaurant for mutton and chicken karhahi. "
                  "A family restaurant where male and female has their separate spacs",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            FloatingActionButton(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminOrWaiter()));
              },
              child: const Icon(Icons.arrow_forward_ios_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
