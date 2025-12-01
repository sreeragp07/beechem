part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final Login? data;

  LoginSuccess({required this.data});
}

final class LoginFailure extends LoginState {}
