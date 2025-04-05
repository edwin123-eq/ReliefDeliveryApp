import 'package:bloc/bloc.dart';
import 'package:deliveryapp/blocs/bloc/bottom%20bloc/bottom_navigation_event.dart';
import 'package:deliveryapp/blocs/bloc/bottom%20bloc/bottom_navigation_state.dart';



class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationInitial()) {
   
     on<SelectTab>((event, emit) {
      emit(TabSelected(event.index));
});
  }
  
}
