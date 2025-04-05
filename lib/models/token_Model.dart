import 'dart:convert';

TokenModel tokenModelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  String accessToken;
  String tokenType;
  int expiresIn;
  DateTime refreshExpiresIn;
  String userName;
  String refreshToken;
  String? userType;
  int userId;
  String? clientid;
  int currencyId;

  TokenModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.userName,
    required this.refreshToken,
    this.userType = '', // Provide a default value
    required this.userId,
    this.clientid = '', // Provide a default value
    required this.currencyId,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        refreshExpiresIn: DateTime.parse(json["refresh_expires_in"]),
        userName: json["user_name"],
        refreshToken: json["refresh_token"],
        userType: json["userType"] != null
            ? json["userType"]
            : '', // Provide a default value
        userId: json["user_id"],
        clientid: json["clientid"] != null
            ? json["clientid"]
            : '', // Provide a default value
        currencyId: json["currencyId"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "refresh_expires_in": refreshExpiresIn.toIso8601String(),
        "user_name": userName,
        "refresh_token": refreshToken,
        "userType": userType,
        "user_id": userId,
        "clientid": clientid,
        "currencyId": currencyId,
      };
}
