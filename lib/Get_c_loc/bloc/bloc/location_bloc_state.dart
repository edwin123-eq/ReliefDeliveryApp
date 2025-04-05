part of 'location_bloc_bloc.dart';

sealed class LocationBlocState  {
}

final class LocationBlocInitial extends LocationBlocState {}

class CustomerLocationSuccessState extends LocationBlocState{
  final CustomerLocation locdetails;
CustomerLocationSuccessState({required this.locdetails});
}

class GetLocationLoading extends LocationBlocState{}

final class GetLocationErrorState extends LocationBlocState{
final String error;
GetLocationErrorState({required this.error});
}