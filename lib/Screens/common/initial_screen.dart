import 'package:flutter/material.dart';
import 'package:order_taking_system/Screens/admin/admin_dashboard.dart';
import 'package:order_taking_system/Screens/admin/generate_token.dart';
import 'package:order_taking_system/Screens/user/items_list_user_side.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  initState() {
    super.initState();
    _init(context);
  }

  _init(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('table')) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ItemsListUserSide()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Type'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: MaterialButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GenerateToken()));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.pink,
                      child: const Center(
                          child: Text(
                        '  Add Waiter  ',
                        style: TextStyle(color: Colors.white),
                      ))))),
          Center(
              child: MaterialButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminDashboard()));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue,
                      child: const Center(
                          child: Text(
                        ' Admin ',
                        style: TextStyle(color: Colors.white),
                      ))))),
          Center(
              child: MaterialButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ItemsListUserSide()));
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.blue,
                      child: const Center(
                          child: Text(
                        '  User  ',
                        style: TextStyle(color: Colors.white),
                      ))))),
        ],
      ),
    );
  }
}
