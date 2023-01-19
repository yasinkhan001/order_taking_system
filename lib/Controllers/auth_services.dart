import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:order_taking_system/Contants/collections.dart';
import 'package:order_taking_system/Models/user_model.dart';
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

  Future<void> register(
      {required String path,
      required extension,
      name,
      required AppUser data}) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(AppUtils.USERS);

    // Create a reference to the Firebase Storage bucket
    final storageRef = FirebaseStorage.instance.ref();
    String url = '';
    File file;

    file = File(path);

// Upload file and metadata to the path 'images/mountains.jpg'
    final uploadTask = await storageRef
        .child("Images/${Random().nextInt(900000)}.$extension")
        .putFile(file.absolute);

    // uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {});
    // await uploadTask.whenComplete(() async {
    //
    // });
    url = await uploadTask.ref.getDownloadURL();
    await users
        .add(data
            .copyWith(
              img: url,
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
  }
}
