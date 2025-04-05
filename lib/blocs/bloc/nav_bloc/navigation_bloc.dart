import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

enum NavigationTab { home, report, settings }

// Navigation Events
abstract class NavigationEvent {}

class NavigationTabChanged extends NavigationEvent {
  final int selectedIndex;
  NavigationTabChanged(this.selectedIndex);
}

// Navigation State
class NavigationState extends Equatable {
  final NavigationTab selectedTab;

  NavigationState({required this.selectedTab});

  @override
  List<Object> get props => [selectedTab];
}

// Navigation BLoC
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(selectedTab: NavigationTab.home)) {
    on<NavigationTabChanged>((event, emit) {
      // Convert selectedIndex to NavigationTab enum
      NavigationTab newTab;
      switch (event.selectedIndex) {
        case 0:
          newTab = NavigationTab.home;
          break;
        case 1:
          newTab = NavigationTab.report;
          break;
        case 2:
          newTab = NavigationTab.settings;
          break;
        default:
          newTab = NavigationTab.home; // Default to home if index is invalid
          break;
      }
      // Emit the new state with the selected tab
      emit(NavigationState(selectedTab: newTab));
    });
  }
}
