//bloc

import 'package:deliveryapp/bill_details_module/bloc/bill_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/bill_details_repo.dart';
import 'bill_details_event.dart';

class BillDetailsBloc extends Bloc<BillDetailsEvent, BillDetailsState> {
  final BillDetailsRepository repository;

  BillDetailsBloc({required this.repository}) : super(BillDetailsInitial()) {
    on<FetchBillDetails>((event, emit) async {
      emit(BillDetailsLoading());
      try {
        final billDetails = await repository.fetchBillDetails(event.dlSaleId, event.dlEmpId);
        emit(BillDetailsLoaded(billDetails));
      } catch (e) {
        emit(BillDetailsError(e.toString()));
      }
    });
  }
}