import 'package:deliveryapp/update_location/bloc/bloc/update_cs_location_event.dart';
import 'package:deliveryapp/update_location/bloc/bloc/update_cs_location_state.dart';
import 'package:deliveryapp/update_location/controller/update_loc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository repository;

  LocationBloc({required this.repository}) : super(LocationInitial()) {
    on<GetCurrentLocationRequested>(_onGetCurrentLocation);
    on<UpdateLocationRequested>(_onUpdateLocation);
  }

  Future<void> _onGetCurrentLocation(
    GetCurrentLocationRequested event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    try {
      final position = await repository.getCurrentLocation();
      emit(LocationUpdateSuccess(

        latitude: position.latitude,
        longitude: position.longitude,
      ));
    } catch (e) {
      emit(LocationUpdateFailure(e.toString()));
    }
  }

  Future<void> _onUpdateLocation(
    UpdateLocationRequested event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    try {
      await repository.updateCustomerLocation(
           customerid: event.customerid,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      emit(LocationUpdateSuccess(
        latitude: event.latitude,
        longitude: event.longitude,
      ));
    } catch (e) {
      emit(LocationUpdateFailure(e.toString()));
    }
  }
}
