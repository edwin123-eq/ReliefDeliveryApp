import 'package:equatable/equatable.dart';

sealed class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

final class BottomNavigationInitial extends BottomNavigationState {}

final class TabSelected extends BottomNavigationState {
  final int index;

  const TabSelected(this.index);

  @override
  List<Object> get props => [index];
}
