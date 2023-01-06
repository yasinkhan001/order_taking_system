import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:order_taking_system/Models/data_model.dart';
import 'package:order_taking_system/Controllers/service_controller.dart';

import 'admin_dashboard.dart';

class GenerateToken extends StatefulWidget {
  const GenerateToken({Key? key}) : super(key: key);

  @override
  State<GenerateToken> createState() => _GenerateTokenState();
}

class _GenerateTokenState extends State<GenerateToken> {
  // String? _chairCount;
  final TextEditingController chairCount = TextEditingController();
  final TextEditingController tableDesc = TextEditingController();
  // final TextEditingController tableStatus = TextEditingController();

  String chair = '';
  String desc = '';
  String status = '';
  List<String> _status = [
    'Pending',
    'Process',
    'Completed',
  ]; // Option 2
  String? _selectedStatus;
  // final chair = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Table"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: chairCount,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Chair Count',
                      hintText: 'Enter Number of Chairs',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: tableDesc,
                    // obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Table Name',
                      hintText: 'Enter Name of table',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  // child: TextField(
                  //   controller: tableStatus,
                  //   // obscureText: true,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Status',
                  //     hintText: 'Status of table',
                  //   ),
                  // ),
                  child: DropdownButton(
                    hint: Text(
                        'Choose Table Status'), // Not necessary for Option 1
                    value: _selectedStatus,

                    items: _status.map((item) {
                      return DropdownMenuItem<String>(
                          child: new Text(item), value: item);
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedStatus = newValue.toString();
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  // style: ElevatedButton.styleFrom(primary: Colors.pink),
                  // textColor: Colors.white,
                  // color: Colors.blue,

                  child: const Text('Add Table'),
                  onPressed: () async {
                    await saveText();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new AdminDashboard()));
                  },
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
            )));
  }

  Future<bool?> saveText() async {
    final String chaircount = chairCount.text;
    final String desc = tableDesc.text;
    final String? _status = _selectedStatus;
    // var textController;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('chair', chaircount);
    // prefs.setString('Desc', desc);
    // prefs.setString('status', status);

    OrderTable myTable = OrderTable(
        id: '',
        descriptions: desc,
        tableChairsCount: int.parse(chairCount.text),
        status: _status);
    FirebaseFirestore.instance
        .collection('tables')
        .add(myTable.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('tables')
          .doc(value.id)
          .update({'id': value.id});
    });

    // Order order = Order(
    //   orderTable: OrderTable(
    //       id: ' ',
    //       descriptions: 'desc',
    //       tableChairsCount: 1,
    //       status: 'Pending'),
    // ).toJson();
    prefs.setString('table', myTable.toJson());
    //Here we'll save our text
  }

  // Future<String?> getText() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.getString('OurText');
  //   return prefs.getString('Desc');
  // }
}
