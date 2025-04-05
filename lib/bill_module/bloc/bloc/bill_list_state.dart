//STATE
part of 'bill_list_bloc.dart';

sealed class BillListState extends Equatable {
  const BillListState();

  @override
  List<Object> get props => [];
}

final class BillListInitial extends BillListState {}

final class BillListLoading extends BillListState {}

final class BillListsucess extends BillListState {
  final List<BillListModel> billlitmodel;
  final List<BillListModel> billListModelFilerList;
  BillListsucess({ required this.billlitmodel, required this.billListModelFilerList});
}

final class BillListerror extends BillListState {
  final String error;
  BillListerror({required this.error});
}
