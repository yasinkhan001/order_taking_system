import 'package:flutter/material.dart';
import 'package:order_taking_system/Screens/admin/admin_dashboard.dart';
import 'package:order_taking_system/Screens/user/add_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
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
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('tables');
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.red,
                      child: const Center(
                          child: Text(
                        '  Delete Table  ',
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
                            builder: (context) => const AddItems()));
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
