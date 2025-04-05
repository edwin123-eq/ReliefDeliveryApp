import 'package:deliveryapp/blocs/summary_bloc.dart/summary_event.dart';
import 'package:deliveryapp/blocs/summary_bloc.dart/summary_state.dart';
import 'package:deliveryapp/home_module/model/summary_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home_module/controller/summary_repo.dart';

// Events


// BLoC
class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {


  SummaryBloc() : super(SummaryInitial()) {
    on<FetchSummaryDetails>(_onFetchSummaryDetails);
  }

  void _onFetchSummaryDetails(
    FetchSummaryDetails event, 
    Emitter<SummaryState> emit
  ) async {
    emit(SummaryLoading());
    try {
      final summaryModel = await fetchSummaryDetails(
        employeeId: event.employeeId, 
        date: event.date
      );
      emit(SummaryLoaded(summaryModel));
    } catch (e) {
      emit(SummaryError(e.toString()));
    }
  }
}
