// To parse this JSON data, do
//
//     final customerLocation = customerLocationFromJson(jsonString);

import 'dart:convert';

CustomerLocation customerLocationFromJson(String str) => CustomerLocation.fromJson(json.decode(str));

String customerLocationToJson(CustomerLocation data) => json.encode(data.toJson());

class CustomerLocation {
    int? accountId;
    String? accountName;
    String? latitude;
    String? longitude;

    CustomerLocation({
        this.accountId,
        this.accountName,
        this.latitude,
        this.longitude,
    });

    factory CustomerLocation.fromJson(Map<String, dynamic> json) => CustomerLocation(
        accountId: json["accountID"],
        accountName: json["accountName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "accountID": accountId,
        "accountName": accountName,
        "latitude": latitude,
        "longitude": longitude,
    };
}