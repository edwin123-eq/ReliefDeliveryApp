// EVENT
part of 'bill_list_bloc.dart';

sealed class BillListEvent extends Equatable {
  const BillListEvent();

  @override
  List<Object> get props => [];
}

class BillTabClicked extends BillListEvent {
  final int index;
  BillTabClicked({required this.index});
}
