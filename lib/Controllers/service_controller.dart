import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:order_taking_system/Models/data_model.dart';
import 'package:order_taking_system/Screens/admin/recipes.dart';

class ServiceController {
  String productCollect = 'products';
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

  Future<void> add(BuildContext context,
      {required path, required extension, name, required Product data}) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(productCollect);

    // Create a reference to the Firebase Storage bucket
    final storageRef = FirebaseStorage.instance.ref();
    String url = '';
    File file;
    if (path != null) {
      file = File(path);

// Upload file and metadata to the path 'images/mountains.jpg'
      final uploadTask = storageRef
          .child("Images/${Random().nextInt(900000)}.$extension")
          .putFile(file.absolute);

      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {});
      await uploadTask.whenComplete(() async {
        url = await uploadTask.snapshot.ref.getDownloadURL();
      });
    }

    users.add(data.copyWith(img: url).toMap()).then((value) {
      users.doc(value.id).update({'id': value.id});
      users
          .doc(value.id)
          .collection(productCollect)
          //add a temp doc
          //because collection creation need at least one doc while creating
          .add(Product(
            createdAt: DateTime.now(),
          ).toMap())
          //delete doc again
          .then((ref) => users
              .doc(value.id)
              .collection(productCollect)
              .doc(ref.id)
              .delete());

      // App.instance
      //     .snackBar(context, text: 'student Added!! ', bgColor: Colors.green);
      Navigator.pop(context);

      return value;
    }).catchError((error) {
      // App.instance.snackBar(context, text: 'Error ', bgColor: Colors.red);
      // return null;
    });
  }

  Future<void> orderStatusChange(status, orderId) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .update({'status': status});
  }
}
