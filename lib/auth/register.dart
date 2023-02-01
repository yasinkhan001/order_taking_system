import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taking_system/Controllers/auth_services.dart';
import 'package:order_taking_system/Models/user_model.dart';
import 'package:order_taking_system/Screens/common/app_colors.dart';
import 'package:order_taking_system/Screens/user/items_list_user_side.dart';
import 'package:email_validator/email_validator.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController waiterPhoneNumber = TextEditingController();
  final TextEditingController waiterName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController desc = TextEditingController();
  bool isLoading = false;
  XFile? img;

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
          iconTheme: IconThemeData(color: Color(0xdc080c52)),
          title: const Text(
            "Register Waiter",
            style: TextStyle(color: Color(0xdc080c52)),
          ),
          backgroundColor: Color(0xF8FFC313),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              color: const Color(0xdc080c52),
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
                              color: const Color(0xF8FFC313),

                              onPressed: () async {
                                ImagePicker imagePicker = ImagePicker();
                                img = (await imagePicker.pickImage(
                                    source: ImageSource.gallery))!;
                                // print(img!.path);
                                // mem = await img.readAsBytes();
                                setState(() {});
                              },
                              child: const Text('Pick Image',
                                  style: TextStyle(color: Color(0xdc080c52))),

                              // controller: _image,
                              // decoration: const InputDecoration(labelText: 'Image'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          style: inputFieldTextColor,
                          controller: waiterName,
                          // obscureText: true,
                          validator: (na) {
                            return !(na!.isNotEmpty)
                                ? "Put your name first"
                                : null;
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                  borderSide:
                                      BorderSide(color: Color(0xF8FFC313))),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          style: inputFieldTextColor,
                          controller: email,
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : "Please enter a valid email",
                          // obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                  borderSide:
                                      BorderSide(color: Color(0xF8FFC313))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                  borderSide: BorderSide(color: Colors.white)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                  borderSide: BorderSide(color: Colors.red)),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: 'Enter Email',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          style: inputFieldTextColor,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          controller: waiterPhoneNumber,
                          validator: (value) {
                            return !(value!.length > 10 && value.length < 12)
                                ? 'Phone number should be 11 digits long'
                                : null;
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.contact_phone_outlined,
                                color: Colors.white,
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                  borderSide:
                                      BorderSide(color: Color(0xF8FFC313))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Contact',
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: 'Contact Number',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          style: inputFieldTextColor,
                          controller: pass,
                          obscureText: true,
                          validator: (pa) {
                            return !(pa!.length > 5)
                                ? 'Password should be 6 digits long'
                                : null;
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.key,
                                color: Colors.white,
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                  borderSide:
                                      BorderSide(color: Color(0xF8FFC313))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Color(0xF8FFC313),
                            border: Border.all(color: Colors.black54)),
                        child: DropdownButton(
                          hint: Row(
                            children: const [
                              Text(
                                'Select Gender',
                                style: TextStyle(color: Color(0xdc080c52)),
                              ),
                            ],
                          ),
                          //
                          isExpanded: true,
                          value: _selectedGender,

                          underline: Container(),

                          items: _gender.map((item) {
                            return DropdownMenuItem<String>(
                                value: item,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      item,
                                      style: const TextStyle(
                                          color: Color(0xdc080c52)),
                                    ),
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
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          style: inputFieldTextColor,
                          controller: desc,
                          validator: (na) {
                            return !(na!.isNotEmpty)
                                ? "Put your descriptions first"
                                : null;
                          },
                          maxLines: 5,
                          decoration: const InputDecoration(
                              // prefixIcon: Icon(
                              //   Icons.email_outlined,
                              //   color: Colors.white,
                              // ),
                              focusedBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.all(
                                  //   Radius.circular(40),
                                  // ),
                                  borderSide:
                                      BorderSide(color: Color(0xF8FFC313))),
                              enabledBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.all(
                                  //   Radius.circular(40),
                                  // ),
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Descriptions',
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: 'Descriptions',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      !isLoading
                          ? Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: SizedBox(
                                width: 150,
                                height: 50,
                                child: ElevatedButton(
                                  // style: ElevatedButton.styleFrom(primary: Colors.pink),
                                  // textColor: Colors.white,
                                  // color: Colors.blue,

                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xF8FFC313),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Color(0xdc080c52), fontSize: 18),
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      submit();
                                    }
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
          ),
        ));
  }

  void submit() async {
    if (img != null && _selectedGender != null) {
      // setState(() {
      //   isLoading = true;
      // });

      await AuthServices().register(context,
          path: img!.path,
          extension: img!.path.split('.').last,
          name: '${DateTime.now()}',
          data: AppUser(
              name: waiterName.text,
              email: email.text,
              phone: waiterPhoneNumber.text,
              description: desc.text,
              gender: _selectedGender,
              password: pass.text,
              img: img!.path));
      // setState(() {
      //   isLoading = false;
      // });

    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Please fill all fields first',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ));
    }
  }
}
