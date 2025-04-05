// Bloc
import 'package:deliveryapp/update_delivery_bill/bloc/update_bill_event.dart';
import 'package:deliveryapp/update_delivery_bill/bloc/update_bill_state.dart';
import 'package:deliveryapp/update_delivery_bill/controller/update_bill_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateDeliveryBloc extends Bloc<UpdateDeliveryEvent, UpdateDeliveryState> {
  final UpdateDeliveryRepository repository;

  UpdateDeliveryBloc({required this.repository}) : super(UpdateDeliveryInitial()) {
    on<UpdateDeliveryRequested>(_onUpdateDeliveryRequested);
  }

  Future<void> _onUpdateDeliveryRequested(
    UpdateDeliveryRequested event,
    Emitter<UpdateDeliveryState> emit,
  ) async {
    emit(UpdateDeliveryLoading());
    try {
      await repository.updateDelivery(event.bill,event.cashAmt,event.onlineAmt,event.status,event.remarks);
      emit(UpdateDeliverySuccess());
    } catch (e) {
      emit(UpdateDeliveryFailure(e.toString()));
    }
  }
}