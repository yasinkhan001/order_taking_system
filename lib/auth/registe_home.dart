// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class RegisterHome extends StatefulWidget {
//   @override
//   _RegisterHomeState createState() => _RegisterHomeState();
// }
//
// class _RegisterHomeState extends State<RegisterHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         actions: <Widget>[],
//         elevation: 0.0,
//         title: Text("HOME"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             FutureBuilder(
//               future: FirebaseAuth.instance.currentUser!,
//               builder: (BuildContext context, AsyncSnapshot user) {
//                 if (user.connectionState == ConnectionState.waiting) {
//                   return Container();
//                 } else {
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         "Welcome ",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 20,
//                         ),
//                       ),
//                       Text(
//                         "${user.data.displayName}!",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontWeight: FontWeight.bold,
//                           fontStyle: FontStyle.italic,
//                           fontSize: 20,
//                         ),
//                       )
//                     ],
//                   );
//                 }
//               },
//             ),
//             FlatButton(
//               splashColor: Colors.white,
//               highlightColor: Theme.of(context).hintColor,
//               child: Text(
//                 "Logout",
//                 style: TextStyle(color: Theme.of(context).primaryColor),
//               ),
//               onPressed: () {
//                 // auth.signOut().then((onValue) {
//                 //   Navigator.of(context).pushReplacementNamed('/login');
//                 // });
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
