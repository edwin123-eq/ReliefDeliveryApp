import 'package:equatable/equatable.dart';

abstract class UPIEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUPIDetailsEvent extends UPIEvent {}
