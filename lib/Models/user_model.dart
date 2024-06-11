// import 'dart:convert';
//
// class AppUser {
//   final String? id;
//   final String? email;
//   final String? name;
//   final String? password;
//   final String? phone;
//   final String? gender;
//   final String? img;
//   final bool? isAdmin;
//
//   final String? description;
//   final DateTime? updatedAt;
//   final DateTime? createdAt;
//   AppUser(
//       {this.id,
//       this.name,
//       this.img,
//       this.email,
//       this.gender,
//       this.description,
//       this.password,
//       this.phone,
//       this.isAdmin,
//       this.createdAt,
//       this.updatedAt});
//
//   AppUser copyWith({
//     String? id,
//     String? email,
//     String? name,
//     String? password,
//     String? phone,
//     String? gender,
//     String? img,
//     bool? isAdmin,
//     String? description,
//     DateTime? updatedAt,
//     DateTime? createdAt,
//   }) =>
//       AppUser(
//           id: id ?? this.id,
//           img: img ?? this.img,
//           description: description ?? this.description,
//           name: name ?? this.name,
//           phone: phone ?? this.phone,
//           password: password ?? this.password,
//           email: email ?? this.email,
//           isAdmin: isAdmin ?? this.isAdmin,
//           updatedAt: updatedAt ?? this.updatedAt,
//           createdAt: createdAt ?? this.createdAt,
//           gender: gender ?? this.gender);
//
//   factory AppUser.fromJson(String str) => AppUser.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//   factory AppUser.fromMap(Map<String, dynamic> json) => AppUser(
//         id: json["id"],
//         name: json['name'],
//         email: json['email'],
//         isAdmin: json['isAdmin'],
//         gender: json['gender'],
//         description: json['description'],
//         password: json['password'],
//         phone: json['phone'],
//         img: json['img'],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "gender": gender,
//         "description": description,
//         "password": password,
//         "img": img,
//         "isAdmin": isAdmin,
//         "phone": phone,
//         "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
//       };
// }
import 'dart:convert';

class AppUser {
  final String? id;
  final String? email;
  final String? name;
  final String? password;
  final String? phone;
  final String? gender;
  final String? img;
  final bool? isAdmin;
  final String? description;
  // final Timestamp? updatedAt;
  // final Timestamp? createdAt;

  AppUser({
    this.id,
    this.name,
    this.img,
    this.email,
    this.gender,
    this.description,
    this.password,
    this.phone,
    this.isAdmin,
    // this.createdAt,
    // this.updatedAt,
  });

  AppUser copyWith({
    String? id,
    String? email,
    String? name,
    String? password,
    String? phone,
    String? gender,
    String? img,
    bool? isAdmin,
    String? description,
    // Timestamp? updatedAt,
    // Timestamp? createdAt,
  }) =>
      AppUser(
        id: id ?? this.id,
        img: img ?? this.img,
        description: description ?? this.description,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        email: email ?? this.email,
        isAdmin: isAdmin ?? this.isAdmin,
        // updatedAt: updatedAt ?? this.updatedAt,
        // createdAt: createdAt ?? this.createdAt,
        gender: gender ?? this.gender,
      );

  factory AppUser.fromJson(String str) => AppUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppUser.fromMap(Map<String, dynamic> json) => AppUser(
        id: json["id"],
        name: json['name'],
        email: json['email'],
        isAdmin: json['isAdmin'],
        gender: json['gender'],
        description: json['description'],
        password: json['password'],
        phone: json['phone'],
        img: json['img'],
        // createdAt: json["created_at"] == null
        //     ? null
        //     : Timestamp.fromDate(DateTime.parse(json["created_at"])),
        // updatedAt: json["updated_at"] == null
        //     ? null
        //     : Timestamp.fromDate(DateTime.parse(json["updated_at"])),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "gender": gender,
        "description": description,
        "password": password,
        "img": img,
        "isAdmin": isAdmin,
        "phone": phone,
        // "created_at": createdAt?.toDate().toIso8601String(),
        // "updated_at": updatedAt?.toDate().toIso8601String(),
      };
}
