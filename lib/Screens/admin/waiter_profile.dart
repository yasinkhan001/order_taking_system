import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Screens/admin/pending_orders.dart';
import 'package:order_taking_system/Screens/admin/recipes.dart';

import '../../Models/data_model.dart';
import 'completed_orders.dart';
import 'generate_token.dart';
import 'inprogress_order.dart';

class WaiterProfile extends StatefulWidget {
  const WaiterProfile({Key? key}) : super(key: key);

  @override
  State<WaiterProfile> createState() => _WaiterProfileState();
}

class _WaiterProfileState extends State<WaiterProfile> {
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
                            builder: (context) => const CompleteOrders()));
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
            title: const Text('Waiter Profile'),
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
                          onTap: () async {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Container(
                              color: Colors.teal,
                              child: Text('${tables[index].descriptions}'),
                            )));
                          },

                          leading: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.pink,
                            child: Image.network(tables[index].img ??
                                'https://cdn2.iconfinder.com/data/icons/circle-icons-1/64/profle-512.png'),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              appDialog(context, tables[index].id);
                            },
                            icon: Icon(Icons.remove_circle),
                          ),

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

  void appDialog(BuildContext context, String? id) {
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

  void delete(String? id) async {
    await FirebaseFirestore.instance.collection('tables').doc(id).delete();
  }
}
