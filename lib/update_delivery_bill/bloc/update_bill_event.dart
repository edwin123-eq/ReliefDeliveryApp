import 'package:deliveryapp/bill_details_module/model/bill_details_model.dart';
import 'package:deliveryapp/update_delivery_bill/model/update_bill.dart';

abstract class UpdateDeliveryEvent {}

class UpdateDeliveryRequested extends UpdateDeliveryEvent {
  // final UpdateDeliveryRequest request;
 // final Map request;
 final BillDetailsModel bill;
 final double cashAmt;
 final double onlineAmt;
 final int status;
 final String remarks;
  UpdateDeliveryRequested(this.bill,this.cashAmt,this.onlineAmt,this.status,this.remarks);
}
