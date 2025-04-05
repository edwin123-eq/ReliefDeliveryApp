// To parse this JSON data, do
//
//     final closingReport = closingReportFromJson(jsonString);

import 'dart:convert';

ClosingReport closingReportFromJson(String str) => ClosingReport.fromJson(json.decode(str));

String closingReportToJson(ClosingReport data) => json.encode(data.toJson());

class ClosingReport {
    String? employeeName;
    int? totalBills;
    int? deliveredCount;
    int? returnedCount;
    int? partiallyDeliveredCount;
    int? pendingCount;
    double? totalCashReceived;
    double? totalBankReceived;
    double? totalAmount;

    ClosingReport({
        this.employeeName,
        this.totalBills,
        this.deliveredCount,
        this.returnedCount,
        this.partiallyDeliveredCount,
        this.pendingCount,
        this.totalCashReceived,
        this.totalBankReceived,
        this.totalAmount,
    });

    factory ClosingReport.fromJson(Map<String, dynamic> json) => ClosingReport(
        employeeName: json["employeeName"],
        totalBills: json["totalBills"],
        deliveredCount: json["deliveredCount"],
        returnedCount: json["returnedCount"],
        partiallyDeliveredCount: json["partiallyDeliveredCount"],
        pendingCount: json["pendingCount"],
        totalCashReceived: json["totalCashReceived"],
        totalBankReceived: json["totalBankReceived"],
        totalAmount: json["totalAmount"],
    );

    Map<String, dynamic> toJson() => {
        "employeeName": employeeName,
        "totalBills": totalBills,
        "deliveredCount": deliveredCount,
        "returnedCount": returnedCount,
        "partiallyDeliveredCount": partiallyDeliveredCount,
        "pendingCount": pendingCount,
        "totalCashReceived": totalCashReceived,
        "totalBankReceived": totalBankReceived,
        "totalAmount": totalAmount,
    };
}
