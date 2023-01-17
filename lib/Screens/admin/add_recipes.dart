import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taking_system/Controllers/service_controller.dart';
import 'package:order_taking_system/Models/data_model.dart';

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
  List<String> _category = [
    'Fast Food',
    'Karhahi',
    'Appetizer',
    'Juice'
  ]; // Option 2
  String? _selectedCategory;

  final TextEditingController _timestampcreated = TextEditingController();
  final TextEditingController _timestampupdated = TextEditingController();
  XFile? file;
  Uint8List? mem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add recipes'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom + 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField(
              //   keyboardType:
              //       const TextInputType.numberWithOptions(decimal: true),
              //   controller: _docId,
              //   decoration: const InputDecoration(labelText: 'Id'),
              // ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Pick Image'),
                    IconButton(
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        file = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        print(file!.path);
                        mem = await file!.readAsBytes();
                        setState(() {});
                      },
                      icon: const Icon(Icons.camera),
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
                controller: _descriptions,
                decoration: const InputDecoration(labelText: 'Descriptions'),
              ),
              // TextField(
              //   controller: _category,
              //   decoration: const InputDecoration(labelText: 'Category'),
              // ),

              DropdownButton(
                hint: Text(
                    'Please choose a category'), // Not necessary for Option 1
                value: _selectedCategory,

                items: _category.map((item) {
                  return DropdownMenuItem<String>(
                      child: new Text(item), value: item);
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue.toString();
                  });
                },
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
                  final double? price = double.tryParse(_priceController.text);
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
                          quantity: int.parse(quantity),
                          sold: int.parse(sold),
                          left: int.parse(sold),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
