import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Screens/admin/dawer.dart';
import 'package:order_taking_system/Screens/admin/waiter_profile.dart';
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
  Table? waiter;
  String _desc = '';

  @override
  void initState() {
    super.initState();
    // _loadCounter();
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
          endDrawer: AppDrawer(),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: const Text('Waiters'),
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
                    separatorBuilder: (BuildContext con, int ind) =>
                        const Divider(
                      height: 1,
                      color: Colors.grey,
                      thickness: 1,
                    ),

                    itemBuilder: (context, index) {
                      //   final item = _chairCount[index];

                      return ListTile(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WaiterProfile(
                                        waiter: tables[index],
                                      )));
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Container(
                          //   color: Colors.teal,
                          //   child: Text('${tables[index].descriptions}'),
                          // )));
                        },

                        leading: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.pink,
                            foregroundImage: NetworkImage(tables[index].img ??
                                'https://cdn2.iconfinder.com/data/icons/circle-icons-1/64/profle-512.png')),
                        trailing: IconButton(
                          onPressed: () {
                            appDialog(context, tables[index].id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),

                        title: Text('${tables[index].descriptions}'),
                        subtitle: Text('${tables[index].tableChairsCount}'),

                        // style: new ListTileTheme(
                        //   selectedColor: Colors.pink,
                        // ),
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

  appDialog(BuildContext context, id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Are you sure want to delete?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      delete(id);
                      Navigator.pop(context);
                    },
                    child: const Text("Delete")),
              ]);
        });
  }

  delete(id) async {
    await FirebaseFirestore.instance.collection('tables').doc(id).delete();
  }
}
