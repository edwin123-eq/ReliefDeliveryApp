// To parse this JSON data, do
//
//     final billListModel = billListModelFromJson(jsonString);

import 'dart:convert';

List<BillListModel> billListModelFromJson(String str) =>
    List<BillListModel>.from(
        json.decode(str).map((x) => BillListModel.fromJson(x)));

String billListModelToJson(List<BillListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillListModel {
  int dlid;
  int dlsaleid;
  int dlassignedby;
  DateTime dlassignedat;
  int dlempid;
  int dlstatus;
  DateTime dlon;
  double dlcashrcvd;
  double dlbankrcvd;
  String dlremarks;
  String customername;
  String address;
  int quantity;
  double amountreceived;
   String phoneNumber;
   int customerID;

  BillListModel({
    required this.dlid,
    required this.dlsaleid,
    required this.dlassignedby,
    required this.dlassignedat,
    required this.dlempid,
    required this.dlstatus,
    required this.dlon,
    required this.dlcashrcvd,
    required this.dlbankrcvd,
    required this.dlremarks,
    required this.customername,
    required this.address,
    required this.quantity,
    required this.amountreceived,
    required this.phoneNumber,
    required this.customerID,
  });

  factory BillListModel.fromJson(Map<String, dynamic> json) => BillListModel(
        dlid: json["dlid"],
        dlsaleid: json["dlsaleid"],
        dlassignedby: json["dlassignedby"],
        dlassignedat: DateTime.parse(json["dlassignedat"]),
        dlempid: json["dlempid"],
        dlstatus: json["dlstatus"],
        dlon: DateTime.parse(json["dlon"]),
        dlcashrcvd: json["dlcashrcvd"],
        dlbankrcvd: json["dlbankrcvd"],
        dlremarks: json["dlremarks"],
        customername: json["customername"],
        address: json["address"],
        quantity: json["quantity"],
        amountreceived: json["amountreceived"],
         phoneNumber: json["phoneNumber"],
          customerID: json["customerID"],
      );

  Map<String, dynamic> toJson() => {
        "dlid": dlid,
        "dlsaleid": dlsaleid,
        "dlassignedby": dlassignedby,
        "dlassignedat": dlassignedat.toIso8601String(),
        "dlempid": dlempid,
        "dlstatus": dlstatus,
        "dlon": dlon.toIso8601String(),
        "dlcashrcvd": dlcashrcvd,
        "dlbankrcvd": dlbankrcvd,
        "dlremarks": dlremarks,
        "customername": customername,
        "address": address,
        "quantity": quantity,
        "amountreceived": amountreceived,
        "phoneNumber": phoneNumber,
        "customerID":customerID,
      };
}
