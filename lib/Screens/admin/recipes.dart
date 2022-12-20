import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../Models/data_model.dart';
import 'package:order_taking_system/Data/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipes extends StatefulWidget {
  const Recipes({Key? key}) : super(key: key);

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  final TextEditingController _docId = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptions = TextEditingController();
  final TextEditingController _image = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _sold = TextEditingController();
  final TextEditingController _left = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _timestampcreated = TextEditingController();
  final TextEditingController _timestampupdated = TextEditingController();

  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _docId,
                  decoration: const InputDecoration(labelText: 'Id'),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _timestampcreated,
                  decoration: const InputDecoration(labelText: 'created at'),
                ),
                TextField(
                  controller: _timestampupdated,
                  decoration: const InputDecoration(labelText: 'updated at'),
                ),
                TextField(
                  controller: _sold,
                  decoration: const InputDecoration(labelText: 'Sold'),
                ),
                TextField(
                  controller: _left,
                  decoration: const InputDecoration(labelText: 'Left'),
                ),
                TextField(
                  controller: _quantity,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                ),
                TextField(
                  controller: _image,
                  decoration: const InputDecoration(labelText: 'Image'),
                ),
                TextField(
                  controller: _descriptions,
                  decoration: const InputDecoration(labelText: 'Descriptions'),
                ),
                TextField(
                  controller: _category,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String id = _docId.text;
                    final String name = _nameController.text;
                    final double? price =
                        double.tryParse(_priceController.text);
                    final String quantity = _quantity.text;
                    final String sold = _sold.text;
                    final String left = _left.text;
                    final String image = _image.text;
                    final String desc = _descriptions.text;
                    final String cat = _category.text;
                    final String createdAt = _timestampcreated.text;
                    final String updatedAt = _timestampupdated.text;

                    if (price != null) {
                      await _products.add({
                        "id": id,
                        "name": name,
                        "price": price,
                        "quantity": quantity,
                        "sold": sold,
                        "left": left,
                        "img": image,
                        "descriptions": desc,
                        "category": cat,
                        "created_at": createdAt,
                        "updated_at": updatedAt,
                      });

                      _nameController.text = '';
                      _priceController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipes"),
        ),
        body: StreamBuilder(
          stream: _products.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(documentSnapshot['id']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(documentSnapshot['name']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(documentSnapshot['price'].toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(documentSnapshot['category']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(documentSnapshot['price']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(documentSnapshot['sold']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(documentSnapshot['left']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(documentSnapshot['img']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(documentSnapshot['descriptions']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(documentSnapshot['created_at']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(documentSnapshot['updated_at']),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Text("No widget to build");
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
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
//         color: Colors.black12,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: LimitedBox(
//             maxHeight: 390,
//             // width: MediaQuery.of(context).size.width,
//
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SingleChildScrollView(
//                   child: Wrap(
//                     children: [
//                       ColoredBox(
//                         color: Colors.amber,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Padding(
//                               padding: EdgeInsets.all(4.0),
//                               child: Text('Image'),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Text(
//                                 'Product',
//                                 style: Theme.of(context).textTheme.labelLarge,
//                               ),
//                             ),
//                             const Spacer(),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Text(
//                                 'Price',
//                                 style: Theme.of(context).textTheme.labelLarge,
//                               ),
//                             ),
//                             const Spacer(),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 24.0),
//                               child: Text(
//                                 'Quantity',
//                                 style: Theme.of(context).textTheme.labelLarge,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       for (Product product in order.products!)
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Image.network(
//                                   product.img!,
//                                   width: 45,
//                                   height: 45,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Text(
//                                 product.name!,
//                                 style: Theme.of(context).textTheme.labelLarge,
//                               ),
//                             ),
//                             const Spacer(),
//                             Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Text(
//                                 '${product.price} PKR',
//                                 style: Theme.of(context).textTheme.labelLarge,
//                               ),
//                             ),
//                             const Spacer(),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 24.0),
//                               child: Text(
//                                 product.quantity!.toString(),
//                                 style: Theme.of(context).textTheme.labelLarge,
//                               ),
//                             ),
//                           ],
//                         ),
//                     ],
//                   ),
//                 ),
//                 ColoredBox(
//                   color: Colors.white.withOpacity(0.1),
//                   child: Row(
//                     children: [
//                       // Padding(
//                       //   padding: const EdgeInsets.symmetric(
//                       //       horizontal: 4.0, vertical: 25),
//                       //   child: Text(
//                       //     'Total:',
//                       //     style: Theme.of(context).textTheme.headline5,
//                       //   ),
//                       // ),
//                       // const Spacer(),
//                       // Padding(
//                       //   padding: const EdgeInsets.symmetric(
//                       //       horizontal: 24.0, vertical: 25),
//                       //   child: Text(
//                       //     order.products!
//                       //         .map((e) => e.price! * e.quantity!)
//                       //         .reduce((a, b) => a + b)
//                       //         .toString(),
//                       //     style: Theme.of(context).textTheme.headline5,
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     // Padding(
//                     //   padding: const EdgeInsets.all(4.0),
//                     //   child: Text(
//                     //     'Status:',
//                     //     style: Theme.of(context)
//                     //         .textTheme
//                     //         .labelMedium!
//                     //         .copyWith(fontWeight: FontWeight.w700),
//                     //   ),
//                     // ),
//                     // Padding(
//                     //   padding: const EdgeInsets.all(4.0),
//                     //   child: Text(
//                     //     order.status!,
//                     //     style: Theme.of(context).textTheme.labelMedium,
//                     //   ),
//                     // ),
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
//                     order.descriptions!,
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ),
//                 const Spacer(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: ElevatedButton(
//                           onPressed: () {}, child: const Text('Delete')),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: ElevatedButton(
//                           onPressed: () {}, child: const Text('Edit')),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

_openPopup(context) {
  Alert(
      context: context,
      title: "Add Recipe",
      content: Column(
        children: const <Widget>[
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.food_bank),
              labelText: 'Name',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.currency_bitcoin),
              labelText: 'Price',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.ac_unit_outlined),
              labelText: 'Quantity',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.image),
              labelText: 'Image',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.description),
              labelText: 'Description',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Add",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

// _getFromGallery() async {
//   PickedFile? pickedFile = await ImagePicker().getImage(
//     source: ImageSource.gallery,
//     maxWidth: 1800,
//     maxHeight: 1800,
//   );
//   if (pickedFile != null) {
//     File imageFile = File(pickedFile.path);
//   }
// }
