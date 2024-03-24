// To parse this JSON data, do
//
//     final homeStatusModel = homeStatusModelFromJson(jsonString);

import 'dart:convert';

HomeStatusModel homeStatusModelFromJson(dynamic str) =>
    HomeStatusModel.fromJson(str);

String homeStatusModelToJson(HomeStatusModel data) =>
    json.encode(data.toJson());

class HomeStatusModel {
  List<Datum>? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  HomeStatusModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory HomeStatusModel.fromJson(Map<String, dynamic> json) =>
      HomeStatusModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
        pagination: json["pagination"] == null
            ? []
            : List<dynamic>.from(json["pagination"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
        "pagination": pagination == null
            ? []
            : List<dynamic>.from(pagination!.map((x) => x)),
      };
}

class Datum {
  dynamic id;
  String? name;
  dynamic total;

  Datum({this.id, this.name, this.total});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "total": total,
      };
}
