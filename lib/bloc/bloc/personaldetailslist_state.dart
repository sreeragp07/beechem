part of 'personaldetailslist_bloc.dart';

@immutable
sealed class PersonaldetailslistState {}

final class PersonaldetailslistInitial extends PersonaldetailslistState {}

final class PersonaldetailslistLoading extends PersonaldetailslistState {}

final class PersonaldetailslistSuccess extends PersonaldetailslistState {
  final PersonalDetails? data;

  PersonaldetailslistSuccess({required this.data});
}

final class PersonaldetailslistFailure extends PersonaldetailslistState {}
