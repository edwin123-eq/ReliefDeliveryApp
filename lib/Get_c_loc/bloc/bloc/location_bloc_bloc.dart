import 'package:bloc/bloc.dart';
import 'package:deliveryapp/Get_c_loc/controller/get_loc.dart';
import 'package:deliveryapp/Get_c_loc/model/Loc_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'location_bloc_event.dart';
part 'location_bloc_state.dart';

class LocationBlocBloc extends Bloc<LocationBlocEvent, LocationBlocState> {
  LocationBlocBloc() : super(LocationBlocInitial()) {
    on<LocationBlocEvent>((event, emit) async {
      emit(GetLocationLoading());
     try{
       if(event is GetLocation){
        final customerLocation = await getCustomerLocation(customerid: event.customerId);
        emit(CustomerLocationSuccessState(locdetails: customerLocation));
      }
     }catch(e){
      emit(GetLocationErrorState(error: e.toString()));
     }
    });
  }
}
