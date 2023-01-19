import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taking_system/Controllers/auth_services.dart';
import 'package:order_taking_system/Models/user_model.dart';
import 'package:order_taking_system/Screens/user/items_list_user_side.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // String? _chairCount;
  // String phoneNumber = '+92334 50 50 505';
  // PhoneNumber number = PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber);
  // String parsableNumber = number.parseNumber();
  // `controller reference`.text = parsableNumber
  final TextEditingController waiterPhoneNumber = TextEditingController();
  final TextEditingController waiterName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController desc = TextEditingController();
  bool isLoading = false;
  XFile? img;
  // final TextEditingController tableStatus = TextEditingController();

  // String chair = '';
  // String desc = '';
  // String status = '';
  // final List<String> _status = [
  //   'Pending',
  //   'Process',
  //   'Completed',
  // ]; // Option 2
  // String? _selectedStatus;

  final List<String> _gender = [
    'Male',
    'Female',
    'Other',
  ]; // Option 2
  String? _selectedGender;
  // final chair = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register Waiter"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (img?.path != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: ColoredBox(
                                color: Colors.black26,
                                child: Image.file(
                                  File(img!.path),
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
                                    child: Icon(
                                      Icons.person,
                                      size: 55,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          MaterialButton(
                            color: Colors.blue,
                            onPressed: () async {
                              ImagePicker imagePicker = ImagePicker();
                              img = (await imagePicker.pickImage(
                                  source: ImageSource.gallery))!;
                              // print(img!.path);
                              // mem = await img.readAsBytes();
                              setState(() {});
                            },
                            child: const Text('Pick Image'),
                            // controller: _image,
                            // decoration: const InputDecoration(labelText: 'Image'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        controller: waiterPhoneNumber,
                        validator: (value) {
                          return !(value!.length > 10 && value.length < 12)
                              ? 'Inter a valid number'
                              : null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Contact',
                          hintText: 'Enter Waiter Contact',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        controller: waiterName,
                        // obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: ' Name',
                          hintText: 'Enter Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: email,
                        // obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter Email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: pass,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter Password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: desc,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Descriptions',
                          hintText: 'Enter Descriptions',
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black54)),
                      child: DropdownButton(
                        hint: Row(
                          children: const [
                            Text('Select Gender'),
                          ],
                        ), //
                        isExpanded: true,
                        value: _selectedGender,
                        underline: Container(),

                        items: _gender.map((item) {
                          return DropdownMenuItem<String>(
                              value: item,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(item),
                                ],
                              ));
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedGender = newValue.toString();
                          });
                        },
                      ),
                    ),
                    !isLoading
                        ? Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: ElevatedButton(
                              // style: ElevatedButton.styleFrom(primary: Colors.pink),
                              // textColor: Colors.white,
                              // color: Colors.blue,

                              child: const Text('Register'),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  submit();
                                  // Navigator.pushAndRemoveUntil(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ItemsListUserSide()),
                                  //     (route) => false);
                                }
                              },
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: Center(
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
    if (img != null) {
      setState(() {
        isLoading = true;
      });

      await AuthServices().register(
          path: img!.path,
          extension: img!.path.split('.').last,
          data: AppUser(
              name: waiterName.text,
              email: email.text,
              phone: waiterPhoneNumber.text,
              description: desc.text,
              gender: _selectedGender,
              password: pass.text,
              img: img!.path));
      setState(() {
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Please Pick Image First',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ));
    }
  }
}
