import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Screens/admin/pending_orders.dart';
import 'package:order_taking_system/Screens/admin/recipes.dart';

import '../../Models/data_model.dart';
import 'completed_orders.dart';
import 'add_waiter.dart';
import 'inprogress_order.dart';

class WaiterProfile extends StatefulWidget {
  const WaiterProfile({required this.waiter, this.isSales = false, Key? key})
      : super(key: key);
  final OrderTable waiter;
  final bool isSales;
  @override
  State<WaiterProfile> createState() => _WaiterProfileState();
}

class _WaiterProfileState extends State<WaiterProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('Waiter Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              !widget.isSales
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.pink,
                              foregroundImage: NetworkImage(widget.waiter.img ??
                                  'https://cdn2.iconfinder.com/data/icons/circle-icons-1/64/profle-512.png')),
                        ),
                        Card(
                            child: ListTile(
                          title: const Text(
                            "Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          trailing: Text(
                            widget.waiter.descriptions ?? ' no Name',
                          ),
                        )),
                        Card(
                            child: ListTile(
                          title: const Text(
                            "Gender",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          trailing: Text(
                            widget.waiter.gender ?? ' Gender',
                          ),
                        )),
                        Card(
                            child: ListTile(
                          title: const Text(
                            "Phone",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          trailing: Text(
                            widget.waiter.tableChairsCount.toString(),
                          ),
                        )),
                        Card(
                            child: ListTile(
                          title: const Text(
                            "Unique Id",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          trailing: Text(
                            widget.waiter.id.toString(),
                          ),
                        )),
                      ],
                    )
                  : Container(),
              widget.isSales
                  ? Card(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('orders')
                              .where('status', isEqualTo: 'Completed')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snap) {
                            if (snap.hasData) {
                              var bb = snap.data!.docs;
                              print('Length:${bb.length}');
                              List<UserOrder> orders = bb
                                  .map((a) =>
                                      UserOrder.fromJson(jsonEncode(a.data())))
                                  .where((order) =>
                                      order.createdAt!.isAfter(DateTime.now()
                                          .subtract(const Duration(days: 1))) &&
                                      order.orderTable!.id == widget.waiter.id)
                                  .toList();
                              var totalSales = orders
                                  .map((e) => e.products
                                      ?.map((e) =>
                                          e.price! * e.quantity!.toDouble())
                                      .fold<double>(0.0, (a, b) => a + b))
                                  .fold<double>(
                                      0.0, (double? a, double? b) => a! + b!);

                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      title: const Text(
                                        "Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                      trailing: Text(
                                        widget.waiter.descriptions ??
                                            ' no Name',
                                      ),
                                    ),
                                    Text(
                                      'Today Sales:',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    Text(
                                      '$totalSales',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }))
                  : Container()
            ],
          ),
        ));
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
