//event
abstract class BillDetailsEvent {}

class FetchBillDetails extends BillDetailsEvent {
  final String dlSaleId;
  final String dlEmpId;

  FetchBillDetails({required this.dlSaleId, required this.dlEmpId});
}