import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Models/user_model.dart';
import 'package:order_taking_system/Screens/common/app_colors.dart';

import '../../Models/data_model.dart';

class WaiterProfile extends StatefulWidget {
  const WaiterProfile({required this.waiter, this.isSales = false, Key? key})
      : super(key: key);
  final AppUser waiter;
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
          title: Text(
            'Waiter ${widget.isSales ? 'Sales' : 'Profile'}',
            style: appThemeColor,
          ),
          iconTheme: const IconThemeData(color: appBarIconColor),
          backgroundColor: const Color(0xF8FFC313),
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
                            widget.waiter.name ?? ' no Name',
                          ),
                        )),
                        Card(
                            child: ListTile(
                          title: const Text(
                            "Email",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          trailing: Text(
                            widget.waiter.email ?? ' no Email',
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
                            widget.waiter.phone.toString(),
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
                                      order.user!.id == widget.waiter.id)
                                  .toList();
                              var totalSales = orders
                                  .map((e) => e.products
                                      ?.map((e) =>
                                          e.price! * e.quantity!.toDouble())
                                      .fold<double>(0.0, (a, b) => a + b))
                                  .fold<double>(
                                      0.0, (double? a, double? b) => a! + b!);
                              var totalItems = orders.length;

                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: CircleAvatar(
                                          radius: 55,
                                          backgroundColor: Colors.pink,
                                          foregroundImage: NetworkImage(widget
                                                  .waiter.img ??
                                              'https://cdn2.iconfinder.com/data/icons/circle-icons-1/64/profle-512.png')),
                                    ),
                                    Container(
                                      color: appBarColor,
                                      child: ListTile(
                                        title: const Text(
                                          "Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        trailing: Text(
                                          widget.waiter.name ?? ' no Name',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Today Sales:',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge,
                                          ),
                                          Text(
                                            '$totalSales',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total Orders:',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge,
                                          ),
                                          Text(
                                            '$totalItems',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge,
                                          ),
                                        ],
                                      ),
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
