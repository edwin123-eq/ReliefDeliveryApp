part of 'location_bloc_bloc.dart';

@immutable
sealed class LocationBlocEvent {
}

final class GetLocation extends LocationBlocEvent{
  final int customerId;
  GetLocation({required this.customerId});
}