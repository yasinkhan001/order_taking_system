import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Contants/collections.dart';
import 'package:order_taking_system/Controllers/auth_services.dart';
import 'package:order_taking_system/Models/data_model.dart';
import 'package:order_taking_system/Screens/common/app_colors.dart';

class AddTable extends StatefulWidget {
  const AddTable({Key? key}) : super(key: key);

  @override
  State<AddTable> createState() => _AddTableState();
}

class _AddTableState extends State<AddTable> {
  final TextEditingController name = TextEditingController();

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Table",
            style: appThemeColor,
          ),
          iconTheme: IconThemeData(color: appBarIconColor),
          backgroundColor: Color(0xF8FFC313),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 450,
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(AppUtils.TABLES)
                            .orderBy('descriptions', descending: false)
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                          if (snap.hasData) {
                            List<OrderTable> tables = snap.data!.docs
                                .map((e) =>
                                    OrderTable.fromJson(jsonEncode(e.data())))
                                .toList();
                            return ListView.builder(
                                itemCount: tables.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: appBarColor,
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 15),
                                            child: Text(
                                              ("${index + 1}.").toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge,
                                            ),
                                          ),
                                          Text(
                                            "Table ${tables[index].descriptions}",
                                            style: const TextStyle(
                                                color: Color(0xdc080c52),
                                                fontSize: 18),
                                          ),
                                        ],
                                      ));
                                });
                          } else if (snap.hasError) {
                            return Center(child: Text(snap.error.toString()));
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        controller: name,
                        // obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.add_circle_outline_sharp,
                            color: appBarIconColor,
                          ),
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.all(
                          //       Radius.circular(40),
                          //     ),
                          //     borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                              borderSide: BorderSide(color: Color(0xF8FFC313))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                              borderSide: BorderSide(color: appBarIconColor)),
                          labelText: 'Table',
                          labelStyle: TextStyle(color: appBarIconColor),
                          hintText: 'Add Table',
                          hintStyle: TextStyle(color: appBarIconColor),
                        ),
                      ),
                    ),
                    !isLoading
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // primary: Color(0xF8FFC313),
                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                // style: ElevatedButton.styleFrom(primary: Colors.pink),
                                // textColor: Colors.white,
                                // color: Colors.blue,

                                child: const Text(
                                  'Add',
                                  style: appThemeColor,
                                ),
                                onPressed: () async {
                                  submit();
                                },
                              ),
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),

                    // ElevatedButton(
                    //   // style: ElevatedButton.styleFrom(primary: Colors.pink),
                    //   // textColor: Colors.white,
                    //   // color: Colors.blue,
                    //
                    //   child: Text('get Table'),
                    //   onPressed: () async {
                    //     chair = (await getText())!;
                    //     setState(() {});
                    //   },
                    // ),
                    // Text(chair),
                    // Text(desc),
                  ],
                )),
          ),
        ));
  }

  void submit() async {
    setState(() {
      isLoading = true;
    });
    OrderTable orderTable = OrderTable(
      descriptions: name.text,
      tableChairsCount: 0,
      status: 'Pending',
    );

    await AuthServices().addTable(data: orderTable);

    setState(() {
      isLoading = false;
      // Navigator.pop(context);
    });
  }
}
