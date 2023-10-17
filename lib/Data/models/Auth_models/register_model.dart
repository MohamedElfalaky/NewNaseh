// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(dynamic str) => RegisterModel.fromJson(str);

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  Data? data;
  int? status;
  String? message;
  List<dynamic>? pagination;

  RegisterModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    status: json["status"],
    message: json["message"],
    pagination: json["pagination"] == null ? [] : List<dynamic>.from(json["pagination"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "status": status,
    "message": message,
    "pagination": pagination == null ? [] : List<dynamic>.from(pagination!.map((x) => x)),
  };
}

class Data {
  int? id;
  String? avatar;
  String? email;
  String? lang;
  String? fullName;
  String? mobile;
  String? userName;
  String? token;
  int? isNotification;
  int? isAdvice;
  String? rate;
  int? walletBalance;
  int? bankComplete;
  int? statusCount;

  Data({
    this.id,
    this.avatar,
    this.email,
    this.lang,
    this.fullName,
    this.mobile,
    this.userName,
    this.token,
    this.isNotification,
    this.isAdvice,
    this.rate,
    this.walletBalance,
    this.bankComplete,
    this.statusCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    avatar: json["avatar"],
    email: json["email"],
    lang: json["lang"],
    fullName: json["full_name"],
    mobile: json["mobile"],
    userName: json["user_name"],
    token: json["token"],
    isNotification: json["is_notification"],
    isAdvice: json["is_advice"],
    rate: json["rate"],
    walletBalance: json["wallet_balance"],
    bankComplete: json["bank_complete"],
    statusCount: json["status_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "email": email,
    "lang": lang,
    "full_name": fullName,
    "mobile": mobile,
    "user_name": userName,
    "token": token,
    "is_notification": isNotification,
    "is_advice": isAdvice,
    "rate": rate,
    "wallet_balance": walletBalance,
    "bank_complete": bankComplete,
    "status_count": statusCount,
  };
}
