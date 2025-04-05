// To parse this JSON data, do
//
//     final whatsappMsgModel = whatsappMsgModelFromJson(jsonString);

import 'dart:convert';

WhatsappMsgModel whatsappMsgModelFromJson(String str) => WhatsappMsgModel.fromJson(json.decode(str));

String whatsappMsgModelToJson(WhatsappMsgModel data) => json.encode(data.toJson());

class WhatsappMsgModel {
    String message;
    String status;

    WhatsappMsgModel({
        required this.message,
        required this.status,
    });

    factory WhatsappMsgModel.fromJson(Map<String, dynamic> json) => WhatsappMsgModel(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
