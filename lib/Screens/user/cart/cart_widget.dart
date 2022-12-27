import 'package:flutter/material.dart';
import 'package:order_taking_system/Models/data_model.dart';

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

  @override
  Widget build(BuildContext context) {
    cartProducts = widget.products;
    data();
    return Container(
      height: 400,
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
                                                      .quantity! -
                                                  1);
                                      if (cartProducts[index].quantity == 0) {
                                        cartProducts.removeWhere((e) =>
                                            prod.id ==
                                            cartProducts
                                                .firstWhere((e) =>
                                                    e.id ==
                                                    cartProducts[index].id)
                                                .id);
                                      }
                                      // prod.copyWith(quantity: prod.quantity! + 1);
                                      cartProducts
                                          .removeWhere((e) => e.id == prod.id);
                                      cartProducts.insert(index, prod);
                                      data();
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
                                      // prod.copyWith(quantity: prod.quantity! + 1);
                                      cartProducts
                                          .removeWhere((e) => e.id == prod.id);
                                      cartProducts.insert(index, prod);
                                      // cartProducts.add(prod);
                                      data();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.pink,
                                  ))
                            ]),
                      ),
                    );
                  }),
            ),
            Row(
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  total.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
