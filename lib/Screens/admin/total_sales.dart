import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Models/data_model.dart';

class TotalSales extends StatelessWidget {
  const TotalSales({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Sales'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: 'Completed')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
          if (snap.hasData) {
            var bb = snap.data!.docs;
            print('Length:${bb.length}');
            List<UserOrder> orders = bb
                .map((a) => UserOrder.fromJson(jsonEncode(a.data())))
                .toList();
            var totalSales = orders
                .map((e) => e.products
                    ?.map((e) => e.price! + e.quantity!.toDouble())
                    .fold<double>(0.0, (a, b) => a + b))
                .fold<double>(0.0, (double? a, double? b) => a! + b!);
            print(totalSales);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Sales',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    '$totalSales',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
