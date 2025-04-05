
// States
import '../../home_module/model/summary_model.dart';

abstract class SummaryState {}
class SummaryInitial extends SummaryState {}
class SummaryLoading extends SummaryState {}
class SummaryLoaded extends SummaryState {
  final SummaryModel summaryModel;
  SummaryLoaded(this.summaryModel);
}
class SummaryError extends SummaryState {
  final String errorMessage;
  SummaryError(this.errorMessage);
}