import 'package:flutter/material.dart';
import 'package:order_taking_system/Screens/admin/completed_orders.dart';
import 'package:order_taking_system/auth/register.dart';
import 'package:order_taking_system/Screens/admin/inprogress_order.dart';
import 'package:order_taking_system/Screens/admin/pending_orders.dart';
import 'package:order_taking_system/Screens/admin/recipes.dart';
import 'package:order_taking_system/Screens/admin/total_sales.dart';
import 'package:order_taking_system/Screens/admin/waiter_today_sales.dart';
import 'package:order_taking_system/auth/login.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            title: const Text("Pending"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PendingOrders()));
            },
          )),
          Card(
              child: ListTile(
            title: const Text("In Progress"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InprogressOrders()));
            },
          )),
          Card(
              child: ListTile(
            title: const Text("Completed"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CompleteOrders()));
            },
          )),
          Card(
              child: ListTile(
            title: const Text("Recipes"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Recipes()));
            },
          )),
          Card(
              child: ListTile(
            title: const Text("Add Tables"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Registration()));
            },
          )),
          Card(
              child: ListTile(
            title: const Text("Today's Sales"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TotalSales()));
            },
          )),
          Card(
              child: ListTile(
            title: const Text("Waiters Sales"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WaiterTodaySales()));
            },
          )),
          Card(
              child: ListTile(
            title: const Text("Login"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          )),
        ],
      ),
    );
  }
}
