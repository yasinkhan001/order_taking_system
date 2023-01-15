import 'package:flutter/material.dart';
import 'package:order_taking_system/Screens/admin/dawer.dart';

import '../../Models/data_model.dart';

class WaiterProfile extends StatefulWidget {
  const WaiterProfile({required this.waiter, Key? key}) : super(key: key);
  final OrderTable waiter;
  @override
  State<WaiterProfile> createState() => _WaiterProfileState();
}

class _WaiterProfileState extends State<WaiterProfile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        endDrawer: const AppDrawer(),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('Waiter Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.pink,
                    foregroundImage: NetworkImage(widget.waiter.img ??
                        'https://cdn2.iconfinder.com/data/icons/circle-icons-1/64/profle-512.png')),
              ),
              Card(
                  child: ListTile(
                title: const Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                trailing: Text(
                  widget.waiter.descriptions ?? ' no Name',
                ),
              )),
              Card(
                  child: ListTile(
                title: const Text(
                  "Gender",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                trailing: Text(
                  widget.waiter.gender ?? ' Gender',
                ),
              )),
              Card(
                  child: ListTile(
                title: const Text(
                  "Phone",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                trailing: Text(
                  widget.waiter.tableChairsCount.toString(),
                ),
              )),
              Card(
                  child: ListTile(
                title: const Text(
                  "Unique Id",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                trailing: Text(
                  widget.waiter.id.toString(),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
