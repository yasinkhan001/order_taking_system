import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Contants/widgets.dart';
import 'package:order_taking_system/Controllers/auth_services.dart';
import 'package:order_taking_system/Screens/admin/dawer.dart';
import 'package:order_taking_system/Screens/common/app_colors.dart';
import 'package:order_taking_system/Screens/common/initial_screen.dart';
import 'package:order_taking_system/Screens/user/cart/cart_widget.dart';
import 'package:order_taking_system/Screens/user/orders/orders.dart';
import 'package:order_taking_system/Screens/user/show_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Data/data.dart';
import '../../Models/data_model.dart';
import '../admin/completed_orders.dart';
import '../admin/inprogress_order.dart';
import '../admin/pending_orders.dart';

class ItemsListUserSide extends StatefulWidget {
  const ItemsListUserSide({Key? key, this.product}) : super(key: key);

  final Product? product;

  @override
  State<ItemsListUserSide> createState() => _ItemsListUserSideState();
}

class _ItemsListUserSideState extends State<ItemsListUserSide> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  List<Product> cartProducts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
          // AppDrawer(),
          Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 35.0),
              child: ColoredBox(
                color: Colors.white,
                child: SizedBox(
                  height: 150,
                  width: 250,
                  child: Image(image: AssetImage('assets/tikka.jpeg')),
                ),
              ),
            ),
            Card(
                child: ListTile(
              title: const Text("Placed Order"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UsersSideOrders()));
              },
            )),
            Card(
                child: ListTile(
              title: const Text("Logout"),
              onTap: () {
                AuthServices().logout(context);
              },
            )),
          ],
        ),
      ),

      appBar: AppBar(
        title: const Text('Menu', style: appThemeColor),
        iconTheme: const IconThemeData(color: Color(0xdc080c52)),
        backgroundColor: Color(0xF8FFC313),
        actions: [
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('table');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => InitialScreen()),
                  (route) => false);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: SizedBox(
                width: 35,
                height: 35,
                // child: Icon(
                //   Icons.delete,
                //   color: Colors.red,
                // ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              App.instance.dialog(context,
                  child: CartWidget(
                    products: cartProducts,
                    onChange: (a) {
                      setState(() {
                        cartProducts = a;
                      });
                    },
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SizedBox(
                width: 35,
                height: 35,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      color: Color(0xdc080c52),
                    ),
                    cartProducts.isNotEmpty
                        ? Positioned(
                            top: 14,
                            right: 3,
                            child: Container(
                              width: 15,
                              height: 15,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.redAccent),
                              child: Text(
                                '${cartProducts.length}',
                                style: const TextStyle(
                                    fontSize: 8, color: Colors.white),
                              ),
                            ))
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            List<Product> _products = streamSnapshot.data!.docs
                .map((e) => Product.fromJson(jsonEncode(e.data())))
                .toList();
            return ListView.builder(
              itemCount: _products.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                documentSnapshot.data();

                return Card(
                  child: ExpansionTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        _products[index].img!,
                        // documentSnapshot['img'],
                        // fit: BoxFit.cover,
                        fit: BoxFit.fill,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            List<Product> p = cartProducts
                                .where((e) => e.id == _products[index].id)
                                .toList();

                            if (p.isEmpty) {
                              cartProducts
                                  .add(_products[index].copyWith(quantity: 1));
                            } else {
                              Product prod = p
                                  .firstWhere(
                                      (e) => e.id == _products[index].id)
                                  .copyWith(
                                      quantity: p
                                              .firstWhere((e) =>
                                                  e.id == _products[index].id)
                                              .quantity! +
                                          1);
                              // prod.copyWith(quantity: prod.quantity! + 1);
                              cartProducts.removeWhere((e) => e.id == prod.id);
                              cartProducts.add(prod);
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.pink,
                        )),
                    title: Text(
                      documentSnapshot['name'],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    subtitle: Text(
                      "Price: Rs ${documentSnapshot['price']}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                    children: [
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          'Descriptions',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text('${documentSnapshot['descriptions']}'),
                      ),
                    ],
                  ),
                );

                Card(
                  margin: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              _products[index].img!,
                              // documentSnapshot['img'],
                              // fit: BoxFit.cover,
                              fit: BoxFit.fill,
                              width: 50,
                              height: 50,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                documentSnapshot['name'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Price: Rs ${documentSnapshot['price']}",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  List<Product> p = cartProducts
                                      .where((e) => e.id == _products[index].id)
                                      .toList();

                                  if (p.isEmpty) {
                                    cartProducts.add(
                                        _products[index].copyWith(quantity: 1));
                                  } else {
                                    Product prod = p
                                        .firstWhere(
                                            (e) => e.id == _products[index].id)
                                        .copyWith(
                                            quantity: p
                                                    .firstWhere((e) =>
                                                        e.id ==
                                                        _products[index].id)
                                                    .quantity! +
                                                1);
                                    // prod.copyWith(quantity: prod.quantity! + 1);
                                    cartProducts
                                        .removeWhere((e) => e.id == prod.id);
                                    cartProducts.add(prod);
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.pink,
                              ))
                        ]),
                  ),
                );
              },
            );
          }
          return const Text("No widget to build");
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const ShowItems()));
      //     // Add your onPressed code here!
      //   },
      //   label: const Text('Proceed to Order'),
      //   icon: const Icon(Icons.arrow_forward_ios_sharp),
      //   backgroundColor: Colors.pink,
      // ),
    );
  }
}
