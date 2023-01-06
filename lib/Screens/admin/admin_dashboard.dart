import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Screens/admin/completed_orders.dart';
import 'package:order_taking_system/Screens/admin/generate_token.dart';
import 'package:order_taking_system/Screens/admin/inprogress_order.dart';
import 'package:order_taking_system/Screens/admin/order_list.dart';
import 'package:order_taking_system/Screens/admin/pending_orders.dart';
import 'package:order_taking_system/Screens/admin/recipes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/data_model.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String _chairCount = '';
  OrderTable? order;
  String _desc = '';

  @override
  void initState() {
    super.initState();
    _loadCounter();
    // OrderTable orderTable = OrderTable.fromJson(_chairCount);
  }

  _loadCounter() async {
    // Future<String?> getText() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   // OrderTable order = OrderTable().fromJson('table');
    //   // Map json = jsonDecode(prefs.getString(''));
    //   var tbl = OrderTable.fromJson(prefs);
    //   prefs.getString('table');
    //
    //   // return prefs.getString('Desc');
    // }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    OrderTable? tbl;
    setState(() {
      // if (order != null) {
      //   OrderTable orderTable = OrderTable.fromJson(_desc);
      //   // Map<String, dynamic> orderTable = json.decode(_chairCount);
      //
      //   _desc = (prefs.getString('table') ?? '');
      //   print(orderTable.descriptions);
      // }

      // OrderTable orderTable = OrderTable.fromJson(_chairCount);
      _chairCount = (prefs.getString('table') ?? '');
      Map<String, dynamic> decodedMap = json.decode(tbl.toString());
      print(decodedMap);
      _desc = (prefs.getString('Desc') ?? '');

      // }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          endDrawer: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 35.0),
                  child: ColoredBox(
                    color: Colors.teal,
                    child: SizedBox(
                      height: 150,
                      width: 250,
                    ),
                  ),
                ),
                Card(
                    child: ListTile(
                  title: const Text("Pending"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PendingOrders()));
                  },
                )),
                Card(
                    child: ListTile(
                  title: const Text("In Progress"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InprogressOrders()));
                  },
                )),
                Card(
                    child: ListTile(
                  title: const Text("Completed"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CompleteOders()));
                  },
                )),
                Card(
                    child: ListTile(
                  title: const Text("Recipes"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Recipes()));
                  },
                )),
                Card(
                    child: ListTile(
                  title: const Text("Add Tables"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GenerateToken()));
                  },
                )),
              ],
            ),
          ),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: const Text('Tables'),
          ),
          body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('tables').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var bb = snapshot.data!.docs;
                  List<OrderTable> tables = bb
                      .map((a) => OrderTable.fromJson(jsonEncode(a.data())))
                      .toList();
                  return ListView.separated(
                    itemCount: tables.length,
                    separatorBuilder: (BuildContext con, int ind) => Divider(
                      height: 1,
                      color: Colors.grey,
                      thickness: 1,
                    ),

                    itemBuilder: (context, index) {
                      //   final item = _chairCount[index];

                      return Container(
                        child: ListTile(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Container(
                              color: Colors.teal,
                              child: Text('${tables[index].descriptions}'),
                            )));
                          },
                          leading: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.pink,
                          ),
                          trailing: Icon(Icons.remove_circle),
                          : () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('tables');
                          },
                          title: Text('${tables[index].descriptions}'),
                          subtitle: Text('${tables[index].tableChairsCount}'),

                          // style: new ListTileTheme(
                          //   selectedColor: Colors.pink,
                          // ),
                        ),
                      );
                    },
                    // children: [
                    //   Card(
                    //       child: Container(
                    //     height: 80,
                    //     width: double.infinity,
                    //     decoration:
                    //         (BoxDecoration(borderRadius: BorderRadius.circular(12))),
                    //     child: Padding(
                    //       padding: EdgeInsets.only(top: 25.0, left: 10),
                    //       child: new Text("Table No: ${_chairCount} ${_desc}",
                    //           style:
                    //               TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    //     ),
                    //   ))
                    // ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}
