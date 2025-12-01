import 'package:beechem/models/login/login.dart';
import 'package:beechem/repository/apiservices.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiServices apiServices;
  LoginBloc(this.apiServices) : super(LoginInitial()) {
    on<CallLoginApiEvent>(callLogin);
  }

  Future<void> callLogin(CallLoginApiEvent event, emit) async {
    emit(LoginLoading());
    try {
      Login response = await apiServices.loginUser(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess(data: response));
      return;
    } catch (e) {
      emit(LoginFailure());
    }
  }
}
