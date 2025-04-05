class UpdateDeliveryRequest {
  final int dlid;
  final int dlsaleid;
  final int dlassignedby;
  final String dlassignedat;
  final int dlempid;
  final int dlstatus;
  final String dlon;
  final double dlcashrcvd;
  final double dlbankrcvd;
  final String dlremarks;
  final String customername;
  final String address;
  final int quantity;
  final double amountreceived;
  final double netSaleAmount;

  UpdateDeliveryRequest({
    this.dlid = 0,
    required this.dlsaleid,
    this.dlassignedby = 0,
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
    required this.netSaleAmount,
  });

  Map<String, dynamic> toJson() => {
        'dlid': dlid,
        'dlsaleid': dlsaleid,
        'dlassignedby': dlassignedby,
        'dlassignedat': dlassignedat,
        'dlempid': dlempid,
        'dlstatus': dlstatus,
        'dlon': dlon,
        'dlcashrcvd': dlcashrcvd,
        'dlbankrcvd': dlbankrcvd,
        'dlremarks': dlremarks,
        'customername': customername,
        'address': address,
        'quantity': quantity,
        'amountreceived': amountreceived,
        'netSaleAmount': netSaleAmount,
      };
}
