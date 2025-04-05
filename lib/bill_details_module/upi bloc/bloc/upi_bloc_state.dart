import 'package:deliveryapp/bill_details_module/model/bill_details_model.dart';
import 'package:equatable/equatable.dart';

abstract class UPIState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UPIInitialState extends UPIState {}

class UPILoadingState extends UPIState {}

class UPILoadedState extends UPIState {
  final UPIDetailsModel upiDetails;

  UPILoadedState(this.upiDetails);

  @override
  List<Object?> get props => [upiDetails];
}

class UPIErrorState extends UPIState {
  final String message;

  UPIErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
