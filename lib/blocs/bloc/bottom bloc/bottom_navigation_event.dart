import 'package:equatable/equatable.dart';

sealed class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class SelectTab extends BottomNavigationEvent {
  final int index;

  const SelectTab(this.index);

  @override
  List<Object> get props => [index];
}
