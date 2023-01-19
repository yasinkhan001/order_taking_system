import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserOrder {
  UserOrder({
    this.id,
    this.orderTable,
    this.orderPrice,
    this.status,
    this.products,
    this.descriptions,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final OrderTable? orderTable;
  final double? orderPrice;
  final String? status;
  final List<Product>? products;
  final String? descriptions;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserOrder copyWith({
    String? id,
    OrderTable? orderTable,
    double? orderPrice,
    String? status,
    List<Product>? products,
    String? descriptions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserOrder(
        id: id ?? this.id,
        orderTable: orderTable ?? this.orderTable,
        orderPrice: orderPrice ?? this.orderPrice,
        status: status ?? this.status,
        products: products ?? this.products,
        descriptions: descriptions ?? this.descriptions,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserOrder.fromJson(String str) => UserOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserOrder.fromMap(Map<String, dynamic> json) => UserOrder(
        id: json["id"],
        orderTable: json["orderTable"] == null
            ? null
            : OrderTable.fromMap(json["orderTable"]),
        orderPrice:
            json["orderPrice"] == null ? null : json["orderPrice"]!.toDouble(),
        status: json["status"],
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromMap(x))),
        descriptions: json["descriptions"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "orderTable": orderTable == null ? null : orderTable!.toMap(),
        "orderPrice": orderPrice,
        "status": status,
        "products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x.toMap())),
        "descriptions": descriptions,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class OrderTable {
  OrderTable({
    this.id,
    this.descriptions,
    this.img,
    this.gender,
    this.tableChairsCount,
    this.status,
  });

  final String? id;
  final String? descriptions;
  final String? img;
  final String? gender;
  final int? tableChairsCount;
  final String? status;

  OrderTable copyWith({
    String? id,
    String? descriptions,
    String? img,
    String? gender,
    int? tableChairsCount,
    String? status,
  }) =>
      OrderTable(
        id: id ?? this.id,
        descriptions: descriptions ?? this.descriptions,
        img: img ?? this.img,
        gender: gender ?? this.gender,
        tableChairsCount: tableChairsCount ?? this.tableChairsCount,
        status: status ?? this.status,
      );

  factory OrderTable.fromJson(String str) =>
      OrderTable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderTable.fromMap(Map<String, dynamic> json) => OrderTable(
        id: json["id"],
        descriptions: json["descriptions"],
        img: json["img"],
        gender: json["gender"],
        tableChairsCount: json["tableChairsCount"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "descriptions": descriptions,
        "img": img,
        "gender": gender,
        "tableChairsCount": tableChairsCount,
        "status": status,
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.img,
    this.left,
    this.sold,
    this.quantity,
    this.price,
    this.category,
    this.descriptions,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? img;
  final int? left;
  final int? sold;
  final int? quantity;
  final double? price;
  final String? category;
  final String? descriptions;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product copyWith({
    String? id,
    String? name,
    String? img,
    int? left,
    int? sold,
    int? quantity,
    double? price,
    String? category,
    String? descriptions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        img: img ?? this.img,
        left: left ?? this.left,
        sold: sold ?? this.sold,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        category: category ?? this.category,
        descriptions: descriptions ?? this.descriptions,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        left: json["left"],
        sold: json["sold"],
        quantity: json["quantity"],
        price: json["price"] == null ? null : json["price"]!.toDouble(),
        category: json["category"],
        descriptions: json["descriptions"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "img": img,
        "left": left,
        "sold": sold,
        "quantity": quantity,
        "price": price,
        "category": category,
        "descriptions": descriptions,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
