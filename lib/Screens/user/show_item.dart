import 'package:flutter/material.dart';
import '../../Data/data.dart';
import '../../Models/data_model.dart';

class ShowItems extends StatefulWidget {
  const ShowItems({Key? key}) : super(key: key);

  @override
  State<ShowItems> createState() => _ShowItemsState();
}

class _ShowItemsState extends State<ShowItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Items"),
      ),
      body: ListView.builder(
          itemCount: dummyOrders.length,
          itemBuilder: (context, index) {
            return ShowItemsTile(
              order: dummyOrders[index],
            );
          }),
      bottomNavigationBar: Row(
        children: [
          // Material(
          //   color: const Color(0xffff8989),
          //   child: InkWell(
          //     onTap: () {
          //       //print('called on tap');
          //     },
          //     child: const SizedBox(
          //       height: kToolbarHeight,
          //       width: 100,
          //       child: Center(
          //         child: Text(
          //           'Click',
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: Material(
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  //print('called on tap');
                },
                child: const SizedBox(
                  height: kToolbarHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Submit Order',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowItemsTile extends StatelessWidget {
  const ShowItemsTile({required this.order, Key? key}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 3,
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LimitedBox(
            maxHeight: 390,
            // width: MediaQuery.of(context).size.width,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Wrap(
                    children: [
                      ColoredBox(
                        color: Colors.amber,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text('Image'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Product',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Price',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                'Quantity',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (Product product in order.products!)
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
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '${product.price} PKR',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                product.quantity!.toString(),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
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
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 25),
                        child: Text(
                          order.products!
                              .map((e) => e.price! * e.quantity!)
                              .reduce((a, b) => a + b)
                              .toString(),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(4.0),
                //       child: Text(
                //         'Status:',
                //         style: Theme.of(context)
                //             .textTheme
                //             .labelMedium!
                //             .copyWith(fontWeight: FontWeight.w700),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.all(4.0),
                //       child: Text(
                //         order.status!,
                //         style: Theme.of(context).textTheme.labelMedium,
                //       ),
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(4.0),
                //   child: Text(
                //     'Descriptions:',
                //     style: Theme.of(context)
                //         .textTheme
                //         .labelMedium!
                //         .copyWith(fontWeight: FontWeight.w700),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(4.0),
                //   child: Text(
                //     order.descriptions!,
                //     style: Theme.of(context).textTheme.bodySmall,
                //   ),
                // ),
                // const Spacer(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: ElevatedButton(
                //           onPressed: () {}, child: const Text('Add to Menu')),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
