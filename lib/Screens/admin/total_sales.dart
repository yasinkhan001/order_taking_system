import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Models/data_model.dart';
import 'package:order_taking_system/Screens/common/app_colors.dart';

class TotalSales extends StatelessWidget {
  const TotalSales({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stateDate = DateTime.now();
    DateTime date = stateDate;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Total Sales',
          style: appThemeColor,
        ),
        iconTheme: const IconThemeData(color: appBarIconColor),
        backgroundColor: const Color(0xF8FFC313),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: 'Completed')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
          if (snap.hasData) {
            var bb = snap.data!.docs;
            // print('Length:${bb.length}');
            List<UserOrder> orders = bb
                .map((a) => UserOrder.fromJson(jsonEncode(a.data())))
                .where((order) => order.createdAt!
                    .isAfter(stateDate.subtract(const Duration(days: 30))))
                .toList();
            var totalSales = orders
                .map((e) => e.products
                    ?.map((e) => e.price! * e.quantity!.toDouble())
                    .fold<double>(0.0, (a, b) => a + b))
                .fold<double>(0.0, (double? a, double? b) => a! + b!);

            var totalItems = orders.length;
            // ?.map((e) => e.name! )
            // .fold<double>(0.0, (a, b) => a + b))
            // .fold<double>(0.0, (double? a, double? b) => a! + b!);
            // print(totalItems);
            // Column(
            //   children: [
            //     ListView.builder(
            //         itemCount: orders.length,
            //         shrinkWrap: true,
            //         itemBuilder: (context, index) {
            //           return Card(
            //             color: Colors.blueGrey,
            //             child: Column(
            //               children: [
            //                 for (Product product in orders[index].products!)
            //                   Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Padding(
            //                         padding: const EdgeInsets.all(4.0),
            //                         child: ClipRRect(
            //                           borderRadius: BorderRadius.circular(10),
            //                           child: Image.network(
            //                             product.img!,
            //                             width: 45,
            //                             height: 45,
            //                           ),
            //                         ),
            //                       ),
            //                       Padding(
            //                         padding: const EdgeInsets.all(4.0),
            //                         child: Text(
            //                           product.name!,
            //                           style: Theme.of(context)
            //                               .textTheme
            //                               .labelLarge,
            //                         ),
            //                       ),
            //                       const Spacer(),
            //                       Padding(
            //                         padding: const EdgeInsets.all(4.0),
            //                         child: Text(
            //                           '${product.price} PKR',
            //                           style: Theme.of(context)
            //                               .textTheme
            //                               .labelLarge,
            //                         ),
            //                       ),
            //                       const Spacer(),
            //                       Padding(
            //                         padding: const EdgeInsets.symmetric(
            //                             horizontal: 24.0),
            //                         child: Text(
            //                           product.quantity!.toString(),
            //                           style: Theme.of(context)
            //                               .textTheme
            //                               .labelLarge,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ColoredBox(
            //                   color: Colors.white.withOpacity(0.1),
            //                   child: Row(
            //                     children: [
            //                       Padding(
            //                         padding: const EdgeInsets.symmetric(
            //                             horizontal: 4.0, vertical: 25),
            //                         child: Text(
            //                           'Total:',
            //                           style:
            //                               Theme.of(context).textTheme.headline5,
            //                         ),
            //                       ),
            //                       const Spacer(),
            //                       Padding(
            //                         padding: const EdgeInsets.symmetric(
            //                             horizontal: 24.0, vertical: 25),
            //                         child: Text(
            //                           orders[index]
            //                               .products!
            //                               .map((e) => e.price! * e.quantity!)
            //                               .reduce((a, b) => a + b)
            //                               .toString(),
            //                           style:
            //                               Theme.of(context).textTheme.headline5,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 Row(children: [
            //                   Padding(
            //                     padding: const EdgeInsets.all(4.0),
            //                     child: Text(
            //                       'Table Name:',
            //                       style: Theme.of(context)
            //                           .textTheme
            //                           .labelMedium!
            //                           .copyWith(fontWeight: FontWeight.w700),
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.all(4.0),
            //                     child: Text(
            //                       orders[index].orderTable!.descriptions ??
            //                           'No Table',
            //                       style:
            //                           Theme.of(context).textTheme.labelMedium,
            //                     ),
            //                   ),
            //                 ]),
            //                 Row(
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.all(4.0),
            //                       child: Text(
            //                         'Waiter:',
            //                         style: Theme.of(context)
            //                             .textTheme
            //                             .labelMedium!
            //                             .copyWith(fontWeight: FontWeight.w700),
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.all(4.0),
            //                       child: Text(
            //                         orders[index].user!.name ?? 'No Table',
            //                         style:
            //                             Theme.of(context).textTheme.labelMedium,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Row(
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.all(4.0),
            //                       child: Text(
            //                         'Date Time:',
            //                         style: Theme.of(context)
            //                             .textTheme
            //                             .labelMedium!
            //                             .copyWith(fontWeight: FontWeight.w700),
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.all(4.0),
            //                       child: Text(
            //                         orders[index]
            //                             .createdAt
            //                             .toString()
            //                             .split('.')
            //                             .first,
            //                         style:
            //                             Theme.of(context).textTheme.labelMedium,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Row(
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.all(4.0),
            //                       child: Text(
            //                         'Status:',
            //                         style: Theme.of(context)
            //                             .textTheme
            //                             .labelMedium!
            //                             .copyWith(fontWeight: FontWeight.w700),
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.all(4.0),
            //                       child: Text(
            //                         orders[index].status ?? 'Null',
            //                         style:
            //                             Theme.of(context).textTheme.labelMedium,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(4.0),
            //                   child: Text(
            //                     'Descriptions:',
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .labelMedium!
            //                         .copyWith(fontWeight: FontWeight.w700),
            //                   ),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(4.0),
            //                   child: Text(
            //                     orders[index].descriptions!,
            //                     style: Theme.of(context).textTheme.bodySmall,
            //                   ),
            //                 ),
            //                 const SizedBox(
            //                   height: 30,
            //                 ),
            //                 // Row(
            //                 //   mainAxisAlignment: MainAxisAlignment.end,
            //                 //   children: [
            //                 //     Padding(
            //                 //       padding: const EdgeInsets.all(5.0),
            //                 //       child: ElevatedButton(
            //                 //           onPressed: () {},
            //                 //           child: const Text('Accept Order')),
            //                 //     ),
            //                 //     Padding(
            //                 //       padding: const EdgeInsets.all(5.0),
            //                 //       child: ElevatedButton(
            //                 //           onPressed: () {},
            //                 //           child: const Text('Pending')),
            //                 //     ),
            //                 //     Padding(
            //                 //       padding: const EdgeInsets.all(5.0),
            //                 //       child: ElevatedButton(
            //                 //           onPressed: () {},
            //                 //           child: const Text('Complete')),
            //                 //     )
            //                 //   ],
            //                 // )
            //               ],
            //             ),
            //           );
            //         })
            //   ],
            // );
            return Container(
              color: alertDialogueColor,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    Center(
                      child: Container(
                        height: 300, width: 250,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: appBarColor,
                        ),
                        margin: EdgeInsets.only(top: 120),
                        // margin: EdgeInsets.symmetric(horizontal: 100),
                        // padding: EdgeInsets.only(top: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Text(
                                'Last 30 Days Sales',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Container(
                              child: Text(
                                'Rs $totalSales/-',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: appBarIconColor,
                              indent: 40,
                              endIndent: 40,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                'Total Orders',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0),
                              child: Text(
                                '$totalItems',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff11014c),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${DateTime.now().subtract(Duration(days: 30)).toString().substring(0, 10)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    '${DateTime.now().toString().substring(0, 10)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        height: 100,
                        width: 100,

                        // child: Icon(
                        //   Icons.rice_bowl_outlined,
                        //   size: 100,
                        // ),
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/tikka.jpeg'),
                              fit: BoxFit.fill,
                            ),
                            // color: appBarColor,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  // Card(
                  //   child: Container(
                  //     height: 80,
                  //     margin: EdgeInsets.symmetric(horizontal: 12),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           'Today Orders',
                  //           style: Theme.of(context).textTheme.headline5,
                  //         ),
                  //         Text(
                  //           '$totalItems',
                  //           style: Theme.of(context).textTheme.headline5,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
