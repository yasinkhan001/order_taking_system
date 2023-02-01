// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Contants/collections.dart';
import 'package:order_taking_system/Contants/widgets.dart';
import 'package:order_taking_system/Models/data_model.dart';
import 'package:order_taking_system/Models/user_model.dart';
import 'package:order_taking_system/Screens/admin/admin_dashboard.dart';
import 'package:order_taking_system/Screens/user/items_list_user_side.dart';
import 'package:order_taking_system/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  Future<String> uploadPhoto(
      {required String? path, name, required extension}) async {
    // StudentNotifier imgProgress = StudentNotifier();
    // Create a reference to the Firebase Storage bucket
    final storageRef = FirebaseStorage.instance.ref();
    String url = '';
    File file;
    if (path != null) {
      file = File(path);

// Upload file and metadata to the path 'images/mountains.jpg'
      final uploadTask = await storageRef
          .child("Tables/$name.$extension")
          .putFile(file.absolute);

// Listen for state changes, errors, and completion of the upload.
//       uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {});
      url = await uploadTask.ref.getDownloadURL();
    }

    return url;
  }

  Future<void> register(BuildContext context,
      {required String path,
      required extension,
      name,
      required AppUser data}) async {
    int registeredUsers = 0;
    CollectionReference users =
        FirebaseFirestore.instance.collection(AppUtils.USERS);
    registeredUsers = await users
        .where("email", isEqualTo: data.email)
        .get()
        .then((value) => value.docs.length);
    if (registeredUsers < 1) {
      // Create a reference to the Firebase Storage bucket
      final storageRef = FirebaseStorage.instance.ref();
      String url = ' ';
      File file;

      file = File(path);

// Upload file and metadata to the path 'images/mountains.jpg'
      TaskSnapshot uploadTask = await storageRef
          .child("Images/${Random().nextInt(900000)}.$extension")
          .putFile(file);

      // uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {});
      // await uploadTask.whenComplete(() async {
      //
      // });

      // print(uploadTask.totalBytes);
      url = await uploadTask.ref.getDownloadURL();
      users
          .add(data
              .copyWith(
                img: url,
                isAdmin: false,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              )
              .toMap())
          .then((value) async {
        await users.doc(value.id).update({'id': value.id});
        await users.doc(value.id).get().then((res) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('user', jsonEncode(res.data()));
        });

        // users
        //     .doc(value.id)
        //     .collection(AppUtils.USERS)
        //     //add a temp doc
        //     //because collection creation need at least one doc while creating
        //     .add(data.copyWith( createdAt: DateTime.now(),updatedAt:  DateTime.now(),).toMap())
        //     //delete doc again
        //     .then((ref) => users
        //         .doc(value.id)
        //         .collection(AppUtils.USERS)
        //         .doc(ref.id)
        //         .delete());

        return value;
      }).catchError((error) {
        // App.instance.snackBar(context, text: 'Error ', bgColor: Colors.red);
        // return null;
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ItemsListUserSide()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("email or phone number already exist"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> addTable({required OrderTable data}) async {
    CollectionReference tbl =
        FirebaseFirestore.instance.collection(AppUtils.TABLES);

    await tbl.add(data.toMap()).then((value) async {
      await tbl.doc(value.id).update({'id': value.id});

      return value;
    }).catchError((error) {
      // App.instance.snackBar(context, text: 'Error ', bgColor: Colors.red);
      // return null;
    });
  }

  Future<void> login(BuildContext context,
      {required email, required password}) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(AppUtils.USERS);
    users
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get()
        .then((res) async {
      if (res.docs.isNotEmpty) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', jsonEncode(res.docs[0].data()));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Successfully!!!'),
            backgroundColor: Colors.green,
          ),
        );
        AppUser user =
            AppUser.fromMap(jsonDecode(jsonEncode(res.docs[0].data())));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            if (user.isAdmin!) {
              return AdminDashboard();
            } else {
              return ItemsListUserSide();
            }
          },
        ), (rt) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unauthenticated'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  Future<void> logout(
    BuildContext context,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully Logout !!!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }

  Future<AppUser> getUser() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var user = preferences.getString('user');
      AppUser appUser = AppUser.fromJson(user!);
      return appUser;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
