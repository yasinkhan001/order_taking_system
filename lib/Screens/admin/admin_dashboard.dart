import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Contants/collections.dart';
import 'package:order_taking_system/Models/user_model.dart';
import 'package:order_taking_system/Screens/admin/completed_orders.dart';
import 'package:order_taking_system/Screens/common/app_colors.dart';
import 'package:order_taking_system/auth/register.dart';
import 'package:order_taking_system/Screens/admin/dawer.dart';
import 'package:order_taking_system/Screens/admin/inprogress_order.dart';
import 'package:order_taking_system/Screens/admin/order_list.dart';
import 'package:order_taking_system/Screens/admin/pending_orders.dart';
import 'package:order_taking_system/Screens/admin/recipes.dart';
import 'package:order_taking_system/Screens/admin/total_sales.dart';
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
          // endDrawer: Drawer(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       const Padding(
          //         padding: EdgeInsets.only(top: 35.0),
          //         child: ColoredBox(
          //           color: Colors.teal,
          //           child: SizedBox(
          //             height: 150,
          //             width: 250,
          //           ),
          //         ),
          //       ),
          //       Card(
          //           child: ListTile(
          //         title: const Text("Pending"),
          //         onTap: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => const PendingOrders()));
          //         },
          //       )),
          //       Card(
          //           child: ListTile(
          //         title: const Text("In Progress"),
          //         onTap: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => const InprogressOrders()));
          //         },
          //       )),
          //       Card(
          //           child: ListTile(
          //         title: const Text("Completed"),
          //         onTap: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => const CompleteOrders()));
          //         },
          //       )),
          //       Card(
          //           child: ListTile(
          //         title: const Text("Recipes"),
          //         onTap: () {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => Recipes()));
          //         },
          //       )),
          //       Card(
          //           child: ListTile(
          //         title: const Text("Add Waiter"),
          //         onTap: () {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => AddWaiter()));
          //         },
          //       )),
          //       Card(
          //           child: ListTile(
          //         title: const Text("Today Sale"),
          //         onTap: () {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => TotalSales()));
          //         },
          //       )),
          //     ],
          //   ),
          // ),
          endDrawer: const AppDrawer(),
          appBar: AppBar(
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   icon: const Icon(Icons.arrow_back_ios),
            // ),
            title: const Text(
              'Waiter',
              style: appThemeColor,
            ),
            iconTheme: IconThemeData(color: appBarIconColor),
            backgroundColor: Color(0xF8FFC313),
          ),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(AppUtils.USERS)
                  .where('isAdmin', isEqualTo: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var bb = snapshot.data!.docs;
                  List<AppUser> tables = bb
                      .map((a) => AppUser.fromJson(jsonEncode(a.data())))
                      .toList();
                  if (tables.isNotEmpty) {
                    return ListView.separated(
                      itemCount: tables.length,
                      separatorBuilder: (BuildContext con, int ind) =>
                          const Divider(
                        // height: 1,
                        // color: Colors.grey,
                        thickness: 0,
                      ),

                      itemBuilder: (context, index) {
                        //   final item = _chairCount[index];

                        return Card(
                          elevation: 5,
                          margin:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: ListTile(
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
                              backgroundImage: NetworkImage(tables[index].img !=
                                      null
                                  ? tables[index].img!.contains('http')
                                      ? tables[index].img!
                                      : "https://cdn2.iconfinder.com/data/icons/circle-icons-1/64/profle-512.png"
                                  : "https://cdn2.iconfinder.com/data/icons/circle-icons-1/64/profle-512.png"),
                              // child:Image.network(tables[index].img ??
                              //     'https://cdn2.iconfinder.com/data/icons/circle-icons-1/64/profle-512.png'),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                appDialog(context, tables[index].id);
                              },
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                            ),

                            title: Text('${tables[index].name}'),
                            subtitle: Text('${tables[index].phone}'),

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
                    return const Center(child: Text('No Waiters'));
                  }
                }
                if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
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
              backgroundColor: alertDialogueColor,
              title: const Text(
                "Are you sure want to delete?",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: appBarColor),
                    )),
                TextButton(
                    onPressed: () {
                      delete(id);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: appBarColor),
                    )),
              ]);
        });
  }

  delete(id) async {
    await FirebaseFirestore.instance.collection('users').doc(id).delete();
  }
}
