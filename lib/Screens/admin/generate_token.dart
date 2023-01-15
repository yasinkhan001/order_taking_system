import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taking_system/Screens/user/add_item.dart';
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
  XFile? img;
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

  List<String> _gender = [
    'Male',
    'Female',
    'Other',
  ]; // Option 2
  String? _selectedGender;
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Pick Image'),
                      IconButton(
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          img = (await imagePicker.pickImage(
                              source: ImageSource.gallery))!;
                          // print(img!.path);
                          // mem = await img.readAsBytes();
                          setState(() {});
                        },
                        icon: const Icon(Icons.camera),
                        // controller: _image,
                        // decoration: const InputDecoration(labelText: 'Image'),
                      ),
                      img?.path != null
                          ? Image.file(
                              File(img!.path),
                              height: 50,
                              width: 50,
                            )
                          : Container(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: chairCount,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact Number',
                      hintText: 'Enter Waiter Contact Number',
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
                      labelText: 'Waiter Name',
                      hintText: 'Enter Waiter Name',
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
                          child: Text(item), value: item);
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedStatus = newValue.toString();
                      });
                    },
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
                    hint: Text('Select Gender'), // Not necessary for Option 1
                    value: _selectedGender,

                    items: _gender.map((item) {
                      return DropdownMenuItem<String>(
                          child: Text(item), value: item);
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue.toString();
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
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminDashboard()),
                        (route) => false);
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
        gender: _selectedGender,
        tableChairsCount: int.parse(chairCount.text),
        status: _status);
    await ServiceController()
        .uploadPhoto(
            path: img?.path,
            name: '${Random().nextInt(500000)}',
            extension: img?.path.split('.').last)
        .then((imgUrl) async {
      FirebaseFirestore.instance
          .collection('tables')
          .add(myTable.copyWith(img: imgUrl).toMap())
          .then((value) async {
        FirebaseFirestore.instance
            .collection('tables')
            .doc(value.id)
            .update({'id': value.id});
        DocumentSnapshot<Map<String, dynamic>> ym = await FirebaseFirestore
            .instance
            .collection('tables')
            .doc(value.id)
            .get();
        // OrderTable.fromJson(ym)
        prefs.setString('table', jsonEncode(ym.data()));
      });
    });

    // Order order = Order(
    //   orderTable: OrderTable(
    //       id: ' ',
    //       descriptions: 'desc',
    //       tableChairsCount: 1,
    //       status: 'Pending'),
    // ).toJson();
    //Here we'll save our text
  }

  // Future<String?> getText() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.getString('OurText');
  //   return prefs.getString('Desc');
  // }
}
