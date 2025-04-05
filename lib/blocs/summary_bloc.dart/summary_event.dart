abstract class SummaryEvent {}
class FetchSummaryDetails extends SummaryEvent {
  final String employeeId;
  final String date;

  FetchSummaryDetails({required this.employeeId, required this.date});
}
