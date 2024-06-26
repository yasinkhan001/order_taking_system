import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Contants/collections.dart';
import 'package:order_taking_system/Models/data_model.dart';
import 'package:order_taking_system/Models/user_model.dart';
import 'package:order_taking_system/Screens/common/app_colors.dart';
import 'package:order_taking_system/Screens/common/duration_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersSideOrders extends StatefulWidget {
  const UsersSideOrders({Key? key}) : super(key: key);

  @override
  State<UsersSideOrders> createState() => _UsersSideOrders();
}

class _UsersSideOrders extends State<UsersSideOrders> {
  String? id;
  Future<String?> myData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? aa = preferences.getString('user');
    Map<String, dynamic> map = json.decode(aa!);
    AppUser waiter = AppUser.fromMap(map);
    print(waiter.id);
    id = waiter.id;
    return waiter.id;
  }

  @override
  initState() {
    super.initState();
    myData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xF8FFC313),
        iconTheme: const IconThemeData(color: Color(0xdc080c52)),
        title: const Text(
          'User Orders',
          style: appThemeColor,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(AppUtils.ORDERS)
              // .orderBy('created_at', descending: true)
              // .where('orderTable.id', isEqualTo: id)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
            if (snap.hasData) {
              var bb = snap.data!.docs;
              List<UserOrder> orders = bb
                  .map((a) => UserOrder.fromJson(jsonEncode(a.data())))
                  .where((e) => e.user?.id == id)
                  .toList();
              orders.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
              return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: appBarColor,
                      child: Column(
                        children: [
                          const ColoredBox(
                            color: appBarIconColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text('Image',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text('Product',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Spacer(),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    'Price',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.0),
                                  child: Text(
                                    'Quantity',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (Product product in orders[index].products!)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
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
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    '${product.price} PKR',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0),
                                  child: Text(
                                    product.quantity!.toString(),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
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
                                        .headlineLarge,
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 25),
                                  child: Text(
                                    orders[index]
                                        .products!
                                        .map((e) => e.price! * e.quantity!)
                                        .reduce((a, b) => a + b)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Table Name:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  orders[index].orderTable!.descriptions ??
                                      'No Table',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Date Time:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
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
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
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
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              Chip(
                                label: Text(
                                  orders[index].status ?? 'Null',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(4.0),
                              //   child: Text(
                              //     orders[index].status ?? 'Null',
                              //     style:
                              //         Theme.of(context).textTheme.labelMedium,
                              //   ),
                              // ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Dine in | Parcel:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  orders[index].descriptions ?? ' ',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: DurationTimer(
                              futureDate: orders[index]
                                  .createdAt!
                                  .add(const Duration(minutes: 30)),
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.all(5.0),
                          //       child: ElevatedButton(
                          //           onPressed: () {
                          //             ServiceController().orderStatusChange(
                          //                 'Process', orders[index].id);
                          //           },
                          //           child: const Text('Accept')),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    );
                  });
            } else if (!snap.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snap.hasError) {
              return Center(
                child: Text(snap.error.toString()),
              );
            } else {
              return const Center(
                child: Text('Unknown Problem'),
              );
            }
          }),
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
