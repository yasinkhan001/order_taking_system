import 'package:flutter/material.dart';
import 'package:order_taking_system/Controllers/auth_services.dart';
import 'package:order_taking_system/Screens/admin/add/add_table.dart';
import 'package:order_taking_system/Screens/admin/completed_orders.dart';
import 'package:order_taking_system/Screens/common/app_colors.dart';
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
      width: MediaQuery.of(context).size.width * 0.9,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ColoredBox(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Image(
                      image: AssetImage('assets/mutton.jpg'),
                    ),
                  ),
                ],
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
              title: const Text("Add Table"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddTable()));
              },
            )),
            // Card(
            //     child: ListTile(
            //   title: const Text("Registration"),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const Registration()));
            //   },
            // )),
            Card(
                child: ListTile(
              title: const Text("Sales"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TotalSales()));
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
            // Card(
            //     child: ListTile(
            //   title: const Text("Login"),
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => const LoginScreen()));
            //   },
            // )),
            Card(
                child: ListTile(
              title: const Text("Logout"),
              onTap: () {
                AuthServices().logout(context);
              },
            )),
          ],
        ),
      ),
    );
  }
}
