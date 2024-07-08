import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taking_system/Contants/collections.dart';
import 'package:order_taking_system/Controllers/service_controller.dart';
import 'package:order_taking_system/Models/data_model.dart';
import 'package:order_taking_system/Screens/common/app_colors.dart';

class AddRecipes extends StatefulWidget {
  const AddRecipes({Key? key}) : super(key: key);

  @override
  State<AddRecipes> createState() => _AddRecipesState();
}

class _AddRecipesState extends State<AddRecipes> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');
  final TextEditingController _docId = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptions = TextEditingController();
  final TextEditingController _image = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _sold = TextEditingController();
  final TextEditingController _left = TextEditingController();
  // final TextEditingController _category = TextEditingController();
  List<String> _category = ['loading...']; // Option 2
  String? _selectedCategory;

  final TextEditingController _timestampcreated = TextEditingController();
  final TextEditingController _timestampupdated = TextEditingController();
  XFile? file;
  Uint8List? mem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCategories();
  }

  _fetchCategories() async {
    await FirebaseFirestore.instance
        .collection(AppUtils.CATEGORIES)
        .orderBy('descriptions', descending: false)
        .get()
        .then((a) {
      _category =
          a.docs.map((e) => e.data()["descriptions"] as String).toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add recipes',
          style: appThemeColor,
        ),
        iconTheme: const IconThemeData(color: appBarIconColor),
        backgroundColor: const Color(0xF8FFC313),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          color: appBarIconColor,
          child: Padding(
            padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TextField(
                //   keyboardType:
                //       const TextInputType.numberWithOptions(decimal: true),
                //   controller: _docId,
                //   decoration: const InputDecoration(labelText: 'Id'),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (file?.path != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: ColoredBox(
                            color: Colors.black26,
                            child: Image.file(
                              File(file!.path),
                              height: 120,
                              width: 120,
                            ),
                          ),
                        )
                      else
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: const ColoredBox(
                              color: Colors.black26,
                              child: Padding(
                                padding: EdgeInsets.all(25.0),
                                child: FaIcon(
                                  FontAwesomeIcons.bowlFood,
                                  size: 55,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      // const Text(
                      //   'Pick Image',
                      //   style: TextStyle(color: appBarColor),
                      // ),

                      MaterialButton(
                        color: appBarColor,
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          file = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          print(file!.path);
                          mem = await file!.readAsBytes();
                          setState(() {});
                        },
                        child: const Text('Pick Image',
                            style: TextStyle(color: appBarIconColor)),
                        // icon: const Icon(Icons.camera),
                        // controller: _image,
                        // decoration: const InputDecoration(labelText: 'Image'),
                      ),
                      mem != null
                          ? Image.memory(
                              mem!,
                              height: 50,
                              width: 50,
                            )
                          : Container(),
                    ],
                  ),
                ),
                TextField(
                  style: inputFieldTextColor,
                  controller: _nameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.rice_bowl_rounded,
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          borderSide: BorderSide(color: Color(0xF8FFC313))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 10,
                ),
                // TextField(
                //   keyboardType:
                //       const TextInputType.numberWithOptions(decimal: true),
                //   controller: _timestampcreated,
                //   decoration: const InputDecoration(labelText: 'created at'),
                // ),
                // TextField(
                //   keyboardType:
                //       const TextInputType.numberWithOptions(decimal: true),
                //   controller: _timestampupdated,
                //   decoration: const InputDecoration(labelText: 'updated at'),
                // ),
                // TextField(
                //   keyboardType:
                //       const TextInputType.numberWithOptions(decimal: true),
                //   controller: _sold,
                //   decoration: const InputDecoration(labelText: 'Sold'),
                // ),
                // TextField(
                //   keyboardType:
                //       const TextInputType.numberWithOptions(decimal: true),
                //   controller: _left,
                //   decoration: const InputDecoration(labelText: 'Left'),
                // ),
                // TextField(
                //   keyboardType:
                //       const TextInputType.numberWithOptions(decimal: true),
                //   controller: _quantity,
                //   decoration: const InputDecoration(labelText: 'Quantity'),
                // ),

                // TextField(
                //   controller: _category,
                //   decoration: const InputDecoration(labelText: 'Category'),
                // ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  // margin: const EdgeInsets.symmetric(horizontal: 1),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color(0xF8FFC313),
                      border: Border.all(color: Colors.black54)),
                  child: DropdownButton(
                    hint: const Text(
                      'Please choose a category',
                      style: TextStyle(color: appBarIconColor),
                    ), // Not necessary for Option 1
                    value: _selectedCategory,

                    items: _category.map((item) {
                      return DropdownMenuItem<String>(
                          value: item, child: new Text(item));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue.toString();
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: inputFieldTextColor,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.currency_ruble_outlined,
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          borderSide: BorderSide(color: Color(0xF8FFC313))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Price',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Price',
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: inputFieldTextColor,
                  controller: _descriptions,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      // prefixIcon: Icon(
                      //   Icons.person_outline,
                      //   color: Colors.white,
                      // ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(color: Color(0xF8FFC313))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Descriptions',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Descriptions',
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // primary: Color(0xF8FFC313),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
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
                      final String cat = _selectedCategory.toString();
                      final String createdAt = _timestampcreated.text;
                      final String updatedAt = _timestampupdated.text;

                      if (price != null) {
                        ServiceController().add(context,
                            path: file!.path,
                            extension: file!.path.split('.').last,
                            data: Product(
                              // id: id,
                              name: name,
                              price: price,
                              quantity: 1,
                              sold: 0,
                              left: 1,
                              img: ' ',
                              descriptions: desc,
                              category: cat,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            ));
                        // await _products.add({
                        //   "id": id,
                        //   "name": name,
                        //   "price": price,
                        //   "quantity": quantity,
                        //   "sold": sold,
                        //   "left": left,
                        //   "img": image,
                        //   "descriptions": desc,
                        //   "category": cat,
                        //   "created_at": createdAt,
                        //   "updated_at": updatedAt,
                        // });

                        _nameController.text = '';
                        _priceController.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text(
                      'Add Recipe',
                      style: TextStyle(
                          color: appBarIconColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
