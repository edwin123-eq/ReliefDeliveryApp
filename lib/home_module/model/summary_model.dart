class SummaryModel {
  final String employeeName;
  final int deliveredCount;
  final int returnedCount;
  final int partiallyDeliveredCount;
  final int pendingCount;
  final double totalCashReceived;
  final double totalBankReceived;

  SummaryModel({
    this.employeeName = '',
    this.deliveredCount = 0,
    this.returnedCount = 0,
    this.partiallyDeliveredCount = 0,
    this.pendingCount = 0,
    this.totalCashReceived = 0,
    this.totalBankReceived = 0,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      employeeName: json['employeeName'] ?? '',
      deliveredCount: json['deliveredCount'] ?? 0,
      returnedCount: json['returnedCount'] ?? 0,
      partiallyDeliveredCount: json['partiallyDeliveredCount'] ?? 0,
      pendingCount: json['pendingCount'] ?? 0,
      totalCashReceived: json['totalCashReceived'] ?? 0,
      totalBankReceived: json['totalBankReceived'] ?? 0,
    );
  }

  // Convenience method to calculate total bills
  int getTotalBills() {
    return deliveredCount +
        returnedCount +
        partiallyDeliveredCount +
        pendingCount;
  }
}
