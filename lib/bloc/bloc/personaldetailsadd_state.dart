part of 'personaldetailsadd_bloc.dart';

@immutable
sealed class PersonaldetailsaddState {}

final class PersonaldetailsaddInitial extends PersonaldetailsaddState {}

final class PersonaldetailsaddLoading extends PersonaldetailsaddState {}

final class PersonaldetailsaddSuccess extends PersonaldetailsaddState {
  final PersonalDetailsAddResponse? data;

  PersonaldetailsaddSuccess({required this.data});
}

final class PersonaldetailsaddFailure extends PersonaldetailsaddState {}
