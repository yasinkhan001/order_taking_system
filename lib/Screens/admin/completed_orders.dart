import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Screens/common/app_colors.dart';
import '../../Models/data_model.dart' as or;

class CompleteOrders extends StatefulWidget {
  const CompleteOrders({Key? key}) : super(key: key);

  @override
  State<CompleteOrders> createState() => _CompleteOrders();
}

class _CompleteOrders extends State<CompleteOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Completed Orders',
          style: appThemeColor,
        ),
        iconTheme: IconThemeData(color: appBarIconColor),
        backgroundColor: Color(0xF8FFC313),
      ),
      body: Column(
        children: [
          ColoredBox(
            color: appBarIconColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Product',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Price',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Quantity',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .where('status', isEqualTo: 'Completed')
                    // .orderBy('created_at', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                  if (snap.hasData) {
                    var bb = snap.data!.docs;
                    List<or.UserOrder> orders = bb
                        .map((a) => or.UserOrder.fromJson(jsonEncode(a.data())))
                        .toList();
                    orders.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

                    return ListView.builder(
                        itemCount: orders.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            color: appBarColor,
                            child: Column(
                              children: [
                                for (or.Product product
                                    in orders[index].products!)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            product.img!,
                                            width: 45,
                                            height: 45,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          product.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          '${product.price} PKR',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: Text(
                                          product.quantity!.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ),
                                    ],
                                  ),
                                ColoredBox(
                                  color: Colors.white.withOpacity(0.1),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 25),
                                        child: Text(
                                          'Total:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 25),
                                        child: Text(
                                          orders[index]
                                              .products!
                                              .map(
                                                  (e) => e.price! * e.quantity!)
                                              .reduce((a, b) => a + b)
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Waiter:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        orders[index].user!.name ?? 'No Table',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Table Name:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      orders[index].orderTable!.descriptions ??
                                          'No Table',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                ]),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Date Time:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        orders[index]
                                            .createdAt
                                            .toString()
                                            .split('.')
                                            .first,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Status:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        orders[index].status ?? 'Null',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Dine in | Parcel: ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      orders[index].descriptions ?? ' ',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     Padding(
                                //       padding: const EdgeInsets.all(5.0),
                                //       child: ElevatedButton(
                                //           onPressed: () {},
                                //           child: const Text('Accept Order')),
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.all(5.0),
                                //       child: ElevatedButton(
                                //           onPressed: () {},
                                //           child: const Text('Pending')),
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.all(5.0),
                                //       child: ElevatedButton(
                                //           onPressed: () {},
                                //           child: const Text('Complete')),
                                //     )
                                //   ],
                                // )
                              ],
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

// class OrderTile extends StatelessWidget {
//   const OrderTile({required this.order, Key? key}) : super(key: key);
//   final Order order;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Card(
//         elevation: 3,
//         color: Colors.blueGrey,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: LimitedBox(
//             maxHeight: 390,
//             // width: MediaQuery.of(context).size.width,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SingleChildScrollView(
//                   child: Wrap(
//                     children: [
//
//
//
//
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
