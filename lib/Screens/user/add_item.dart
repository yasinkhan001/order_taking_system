import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Screens/user/show_item.dart';

import '../../Data/data.dart';
import '../../Models/data_model.dart';

class AddItems extends StatefulWidget {
  const AddItems({Key? key}) : super(key: key);

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
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
                  margin: EdgeInsets.only(top: 22.0, left: 5, right: 5),
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(documentSnapshot['id'].toString()),
                      // ),
                      Row(children: [
                        Image.network(
                          documentSnapshot['img'],
                          // fit: BoxFit.cover,
                          fit: BoxFit.fill,
                          width: 350,
                          height: 200,
                        ),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            documentSnapshot['name'],
                            style: TextStyle(fontSize: 26),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "Price: Rs " + documentSnapshot['price'].toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child:
                      //       Text("Category: " + documentSnapshot['category']),
                      // ),
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

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Description: " +
                                  documentSnapshot['descriptions'],
                              softWrap: false,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis, // new
                            ),
                          ),
                        ],
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ShowItems()));
          // Add your onPressed code here!
        },
        label: const Text('Proceed to Order'),
        icon: const Icon(Icons.arrow_forward_ios_sharp),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
