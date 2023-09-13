// To parse this JSON data, do
//
//     final listOneHome = listOneHomeFromJson(jsonString);

import 'dart:convert';

import '../advice_models/show_advice_model.dart';

ListOneHome listOneHomeFromJson(dynamic str) => ListOneHome.fromJson(str);

String listOneHomeToJson(ListOneHome data) => json.encode(data.toJson());

class ListOneHome {
  List<ShowAdData>? data;
  int? status;
  String? message;
  List<dynamic>? pagination;

  ListOneHome({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory ListOneHome.fromJson(Map<String, dynamic> json) => ListOneHome(
    data: json["data"] == null ? [] : List<ShowAdData>.from(json["data"]!.map((x) => ShowAdData.fromJson(x))),
    status: json["status"],
    message: json["message"],
    pagination: json["pagination"] == null ? [] : List<dynamic>.from(json["pagination"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
    "message": message,
    "pagination": pagination == null ? [] : List<dynamic>.from(pagination!.map((x) => x)),
  };
}

// class HOneData {
//   int? id;
//   String? name;
//   int? price;
//   String? date;
//   Status? status;
//   Client? client;
//
//   HOneData({
//     this.id,
//     this.name,
//     this.price,
//     this.date,
//     this.status,
//     this.client,
//   });
//
//   factory HOneData.fromJson(Map<String, dynamic> json) => HOneData(
//     id: json["id"],
//     name: json["name"],
//     price: json["price"]??0,
//     date: json["date"],
//     status: json["status"] == null ? null : Status.fromJson(json["status"]),
//     client: json["client"] == null ? null : Client.fromJson(json["client"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "price": price,
//     "date": date,
//     "status": status?.toJson(),
//     "client": client?.toJson(),
//   };
// }
//
// class Client {
//   int? id;
//   String? avatar;
//   String? fullName;
//
//   Client({
//     this.id,
//     this.avatar,
//     this.fullName,
//   });
//
//   factory Client.fromJson(Map<String, dynamic> json) => Client(
//     id: json["id"],
//     avatar: json["avatar"],
//     fullName: json["full_name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "avatar": avatar,
//     "full_name": fullName,
//   };
// }
//
// class Status {
//   int? id;
//   String? name;
//
//   Status({
//     this.id,
//     this.name,
//   });
//
//   factory Status.fromJson(Map<String, dynamic> json) => Status(
//     id: json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//   };
// }
