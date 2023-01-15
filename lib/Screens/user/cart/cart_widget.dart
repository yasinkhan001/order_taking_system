import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter/material.dart';
import 'package:order_taking_system/Models/data_model.dart';
import 'package:order_taking_system/Screens/user/result/result_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({required this.onChange, required this.products, Key? key})
      : super(key: key);
  final List<Product> products;
  final void Function(List<Product> products) onChange;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  List<Product> cartProducts = [];
  double total = 0;
  List<double>? prices = [];
  List<double>? quantities = [];

  data() {
    total = 0;
    prices = cartProducts.map((e) => e.price).cast<double>().toList();
    quantities = cartProducts.map((e) => e.quantity!.toDouble()).toList();
    for (int i = 0; i < prices!.length; i++) {
      total = total + (prices![i] * quantities![i]);
    }
  }

  List<String> _options = [
    'Parcel',
    'Dine in',
  ]; // Option 2
  String? _selectedOptions;
  @override
  Widget build(BuildContext context) {
    cartProducts = widget.products;
    data();

    return Container(
      height: 500,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin:
                          const EdgeInsets.only(top: 22.0, left: 5, right: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  widget.products[index].img!,
                                  // fit: BoxFit.cover,
                                  fit: BoxFit.fill,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.products[index].name!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    " ${widget.products[index].price} PKR ",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                              Text(
                                "${widget.products[index].quantity}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (cartProducts
                                          .where((e) =>
                                              e.id == widget.products[index].id)
                                          .isNotEmpty) {
                                        Product prod = cartProducts
                                            .firstWhere((e) =>
                                                e.id ==
                                                widget.products[index].id)
                                            .copyWith(
                                                quantity: cartProducts
                                                        .firstWhere((e) =>
                                                            e.id ==
                                                            widget
                                                                .products[index]
                                                                .id)
                                                        .quantity! -
                                                    1);

                                        if (cartProducts[index].quantity! > 0) {
                                          cartProducts.removeAt(index);
                                          cartProducts.insert(index, prod);
                                        }
                                        if (cartProducts[index].quantity! < 1) {
                                          cartProducts.removeAt(index);
                                        }
                                        data();
                                      }
                                      widget.onChange(cartProducts);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      List<Product> p = cartProducts
                                          .where((e) =>
                                              e.id == widget.products[index].id)
                                          .toList();

                                      Product prod = p
                                          .firstWhere((e) =>
                                              e.id == widget.products[index].id)
                                          .copyWith(
                                              quantity: p
                                                      .firstWhere((e) =>
                                                          e.id ==
                                                          widget.products[index]
                                                              .id)
                                                      .quantity! +
                                                  1);
                                      cartProducts
                                          .removeWhere((e) => e.id == prod.id);
                                      cartProducts.insert(index, prod);
                                      data();
                                      widget.onChange(cartProducts);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.pink,
                                  )),
                            ]),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  hint: const Text(
                      'parcel or dine in ?'), // Not necessary for Option 1
                  value: _selectedOptions,

                  items: _options.map((item) {
                    return DropdownMenuItem<String>(
                        child: Text(item), value: item);
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedOptions = newValue.toString();
                    });
                  },
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  total.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      String? tbl = pref.getString('table');
                      Map<String, dynamic> mp = jsonDecode(tbl!);
                      print(mp);
                      UserOrder order = UserOrder(
                        orderTable: OrderTable.fromMap(mp),
                        orderPrice: total,
                        descriptions: _selectedOptions,
                        products: cartProducts,
                        status: 'Pending',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );

                      await fs.FirebaseFirestore.instance
                          .collection('orders')
                          .add(order.toMap())
                          .then((value) async {
                        _go() => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResultOfOrder(id: value.id)));
                        await fs.FirebaseFirestore.instance
                            .collection('orders')
                            .doc(value.id)
                            .update({'id': value.id});
                        _go();
                        widget.onChange([]);
                      });

                      ///Upload table
                      // await fs.FirebaseFirestore.instance
                      //     .collection('tables')
                      //     .add(OrderTable(
                      //             id: '',
                      //             descriptions: 'lkhkhkh',
                      //             tableChairsCount: 6,
                      //             status: 'Pending')
                      //         .toMap())
                      //     .then((value) async {
                      //   await fs.FirebaseFirestore.instance
                      //       .collection('tables')
                      //       .doc(value.id)
                      //       .update({'id': value.id});
                      // });
                    },
                    child: const Text('Submit Order'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
