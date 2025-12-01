part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class CallLoginApiEvent extends LoginEvent {
  final String email;
  final String password;

  CallLoginApiEvent({required this.email, required this.password});
}
