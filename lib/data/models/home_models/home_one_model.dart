
import 'dart:convert';

import '../advice_models/show_advice_model.dart';

HomeOrdersList listOneHomeFromJson(dynamic str) => HomeOrdersList.fromJson(str);

String listOneHomeToJson(HomeOrdersList data) => json.encode(data.toJson());

class HomeOrdersList {
  List<ShowAdData>? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  HomeOrdersList({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory HomeOrdersList.fromJson(Map<String, dynamic> json) => HomeOrdersList(
        data: json["data"] == null
            ? []
            : List<ShowAdData>.from(
                json["data"]!.map((x) => ShowAdData.fromJson(x))),
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


