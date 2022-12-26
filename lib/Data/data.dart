import 'package:order_taking_system/Models/data_model.dart';

List<Order> dummyOrders = [
  Order(
      id: "1",
      orderPrice: 1200,
      status: 'Pending',
      descriptions: "Nothing...",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      orderTable: OrderTable(
          id: "1",
          tableChairsCount: 6,
          status: "Pending",
          descriptions: "Corner Table"),
      products: [
        Product(
          id: "'1'",
          name: 'Medium Pizza',
          left: 100,
          img:
              'https://th.bing.com/th/id/OIP.doQkirpWK5IzqLIzNBobEQHaFN?pid=ImgDet&rs=1',
          sold: 88,
          quantity: 2,
          price: 800.0,
          category: "FastFood",
          descriptions: 'very delicious',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Product(
          id: '"1"',
          name: 'Chicken Karahi',
          left: 20,
          img:
              'https://th.bing.com/th/id/OIP.nttdhvmMz-wdyfrnDwE-7gHaFj?pid=ImgDet&rs=1',
          sold: 30,
          quantity: 1,
          price: 1200.0,
          category: "Food",
          descriptions: 'very delicious',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ]),
  Order(
      id: "2",
      orderPrice: 1200,
      status: 'Pending',
      descriptions: "Nothing...",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      orderTable: OrderTable(
          id: "2",
          tableChairsCount: 6,
          status: "Pending",
          descriptions: "Corner Table 2"),
      products: [
        Product(
          id: "1",
          name: 'Medium Pizza 2',
          img:
              'https://th.bing.com/th/id/OIP.doQkirpWK5IzqLIzNBobEQHaFN?pid=ImgDet&rs=1',
          left: 100,
          sold: 88,
          quantity: 2,
          price: 800.0,
          category: "FastFood2 ",
          descriptions: 'very delicious',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Product(
          id: '1',
          name: 'Chicken Karahi2',
          img:
              'https://th.bing.com/th/id/OIP.nttdhvmMz-wdyfrnDwE-7gHaFj?pid=ImgDet&rs=1',
          left: 3,
          sold: 30,
          quantity: 1,
          price: 1200.0,
          category: "Food 2",
          descriptions: 'very delicious',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ]),
];
