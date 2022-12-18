import 'package:flutter/material.dart';
import 'package:order_taking_system/Screens/admin/generate_token.dart';
import 'package:order_taking_system/Screens/admin/order_list.dart';
import 'package:order_taking_system/Screens/admin/recipes.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 35.0),
              child: ColoredBox(
                color: Colors.teal,
                child: SizedBox(
                  height: 150,
                  width: 250,
                ),
              ),
            ),
            Card(
                child: ListTile(
              title: const Text("Orders"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const OrderList()));
              },
            )),
            Card(
                child: ListTile(
              title: const Text("Recipes"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Recipes()));
              },
            )),
            Card(
                child: ListTile(
              title: const Text("Generate token"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GenerateToken()));
              },
            )),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Tables'),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
              title: const Text('Table'),
              trailing: Text((index + 1).toString()),
              onTap: () {
                print(index);
              },
            ));
          }),
    );
  }
}
