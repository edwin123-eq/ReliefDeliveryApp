// bill_details_model.dart
class BillDetailsModel {
  final String customerName;
  final String docNum;
  final DateTime docDate;
  final String phoneNumber;
  final int quantity;
  final String address;
  final int status;
  final double amtReceived;
  final int deliveryID;
  final int saleId;
  final int empId;
  final int customerID;
  final String? mode;
  final double totalCashReceived;
  final double totalBankReceived;

  BillDetailsModel({
    required this.customerName,
    required this.docNum,
    required this.docDate,
    required this.phoneNumber,
    required this.quantity,
    required this.address,
    required this.status,
    required this.amtReceived,
    required this.deliveryID,
    required this.saleId,
    required this.empId,
    required this.customerID,
    required this.mode,
    required this.totalCashReceived,
    required this.totalBankReceived,
  });

  factory BillDetailsModel.fromJson(Map<String, dynamic> json) {
    return BillDetailsModel(
      customerName: json['customerName'] ?? '',
      docNum: json['docNum'] ?? '',
      docDate:
          DateTime.parse(json['docDate'] ?? DateTime.now().toIso8601String()),
      phoneNumber: json['phoneNumber'] ?? '',
      quantity: json['quantity'] ?? 0,
      address: json['address'] ?? '',
      status: json['status'] ?? 0,
      amtReceived: (json['amtReceived'] ?? 0).toDouble(),
      deliveryID: json['deliveryID'] ?? 0,
      saleId: json['saleId'] ?? 0,
      empId: json['empId'] ?? 0,
      customerID: json['customerID'] ?? 0,
      mode: json['mode'] ?? '',
      totalCashReceived: (json['totalCashReceived'] ?? 0).toDouble(),
      totalBankReceived: (json['totalBankReceived'] ?? 0).toDouble(),
    );
  }
}

// upi_details_model.dart
class UPIDetailsModel {
  final String upIcode; // Updated to match the key in the response
  final String accountName; // Updated to match the key in the response
  final String currency;

  UPIDetailsModel({
    required this.upIcode,
    required this.accountName,
    required this.currency,
  });

  factory UPIDetailsModel.fromJson(Map<String, dynamic> json) {
    return UPIDetailsModel(
      upIcode: json['upIcode'] ?? '', // Updated to match the response key
      accountName:
          json['accountName'] ?? '', // Updated to match the response key
      currency: json['currency'] ?? 'INR', // Defaulted to 'INR' if not present
    );
  }
}
