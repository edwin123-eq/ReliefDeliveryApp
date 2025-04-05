import 'package:deliveryapp/bill_details_module/controller/bill_details_repo.dart';
import 'package:deliveryapp/bill_details_module/upi%20bloc/bloc/upi_bloc_event.dart';
import 'package:deliveryapp/bill_details_module/upi%20bloc/bloc/upi_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class UPIBloc extends Bloc<UPIEvent, UPIState> {
  final BillDetailsRepository repository;

  UPIBloc(this.repository) : super(UPIInitialState()) {
    on<FetchUPIDetailsEvent>((event, emit) async {
      emit(UPILoadingState());
      try {
        final upiDetails = await repository.fetchUPIDetails();
        emit(UPILoadedState(upiDetails));
      } catch (e) {
        emit(UPIErrorState(e.toString()));
      }
    });
  }
}
