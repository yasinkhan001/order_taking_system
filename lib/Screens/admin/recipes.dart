import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taking_system/Screens/admin/add_recipes.dart';
import 'package:path/path.dart';
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
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  final ImagePicker _picker = ImagePicker();

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    // await showModalBottomSheet(
    //     isScrollControlled: true,
    //     context: context,
    //     builder: (BuildContext ctx) {
    //       return StatefulBuilder(
    //         builder:(ctx)=> ,
    //       );
    //     });
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(documentSnapshot['id'].toString()),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            child: Image.network(
                              documentSnapshot['img'],
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              height: 180,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                documentSnapshot['name'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(documentSnapshot['category']),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Rs: ' +
                                  documentSnapshot['price'].toString()),
                            ),
                            IconButton(
                                onPressed: () {
                                  appDialog(context, documentSnapshot['id']);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(documentSnapshot['quantity'].toString()),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(documentSnapshot['sold'].toString()),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(documentSnapshot['left'].toString()),
                        // ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(documentSnapshot['descriptions']),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child:
                        //       Text(documentSnapshot['created_at'].toString()),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child:
                        //       Text(documentSnapshot['updated_at'].toString()),
                        // ),
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
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddRecipes())),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}

appDialog(BuildContext context, id) {
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

delete(id) async {
  await FirebaseFirestore.instance.collection('products').doc(id).delete();
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
