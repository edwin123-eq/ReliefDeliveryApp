// BlOC

import 'package:bloc/bloc.dart';
import 'package:deliveryapp/bill_module/controller/bill_list_repo.dart';
import 'package:deliveryapp/bill_module/model/bill_list_model.dart';
import 'package:equatable/equatable.dart';

part 'bill_list_event.dart';
part 'bill_list_state.dart';

class BillListBloc extends Bloc<BillListEvent, BillListState> {
  BillListBloc() : super(BillListInitial()) {
    on<BillListEvent>((event, emit) async {
      try {
        if (event is BillTabClicked) {
          emit(BillListLoading());
          final response = await BillService()
              .fetchBillDetails(employeeId: '1001978158', date: '09/12/2024');
          // Filtering data based on dlstatus == 1
          List<BillListModel> filteredBills =
              await BillService().fetchFilteredBills(1);

          event.index;
          emit(BillListsucess(
              billListModelFilerList: filteredBills, billlitmodel: response));
        } else {
          emit(BillListerror(error: "Something went wrong"));
        }
      } catch (e) {
        emit(BillListerror(error: e.toString()));
      }
      // TODO: implement event handler
    });
  }
}
