part of 'personaldetailsadd_bloc.dart';

@immutable
sealed class PersonaldetailsaddEvent {}

class CallPersonalDetailsAddApiEvent extends PersonaldetailsaddEvent {
  final String firstName;
  final String address;
  final String suburb;
  final String state;
  final String postcode;
  final String contactNumber;
  final String status;

  CallPersonalDetailsAddApiEvent({
    required this.firstName,
    required this.address,
    required this.suburb,
    required this.state,
    required this.postcode,
    required this.contactNumber,
    required this.status,
  });
}