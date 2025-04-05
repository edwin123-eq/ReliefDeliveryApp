abstract class UpdateDeliveryState {}

class UpdateDeliveryInitial extends UpdateDeliveryState {}

class UpdateDeliveryLoading extends UpdateDeliveryState {}

class UpdateDeliverySuccess extends UpdateDeliveryState {}

class UpdateDeliveryFailure extends UpdateDeliveryState {
  final String error;
  UpdateDeliveryFailure(this.error);
}
