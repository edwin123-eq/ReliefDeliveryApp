import 'package:equatable/equatable.dart';


abstract class LocationState extends Equatable {
  const LocationState();
  
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationUpdateSuccess extends LocationState {
  final double latitude;
  final double longitude;

  const LocationUpdateSuccess({
    required this.latitude, 
    required this.longitude
  });

  @override
  List<Object> get props => [latitude, longitude];
}

class LocationUpdateFailure extends LocationState {
  final String error;

  const LocationUpdateFailure(this.error);

  @override
  List<Object> get props => [error];
}