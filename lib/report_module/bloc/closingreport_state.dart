part of 'closingreport_bloc.dart';

@immutable
sealed class ClosingreportState  {
}

final class ClosingreportInitial extends ClosingreportState {}

 class ClosingreportSuccessState extends ClosingreportState {
  final ClosingReport closingReport;
  ClosingreportSuccessState({required this.closingReport});
}

final class Closingreporterror extends ClosingreportState {
  final String error;
  Closingreporterror({required this.error});
}

class ClosingreportLoading extends ClosingreportState {}
