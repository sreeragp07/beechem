part of 'personaldetailslist_bloc.dart';

@immutable
sealed class PersonaldetailslistEvent {}

class CallPersonalDetailsApiEvent extends PersonaldetailslistEvent {}