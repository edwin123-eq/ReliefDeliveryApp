import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class UpdateLocationRequested extends LocationEvent {
  final int customerid;
  final double latitude;
  final double longitude;

  const UpdateLocationRequested({
    required this.customerid,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];
}

class GetCurrentLocationRequested extends LocationEvent {}
