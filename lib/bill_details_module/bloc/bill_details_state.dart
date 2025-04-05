//state
import '../model/bill_details_model.dart';

abstract class BillDetailsState {}

class BillDetailsInitial extends BillDetailsState {}

class BillDetailsLoading extends BillDetailsState {}

class BillDetailsLoaded extends BillDetailsState {
  final BillDetailsModel billDetails;

  BillDetailsLoaded(this.billDetails);
}

class BillDetailsError extends BillDetailsState {
  final String error;

  BillDetailsError(this.error);
}