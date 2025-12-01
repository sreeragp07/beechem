import 'package:beechem/models/personaldetails/personaldetails.dart';
import 'package:beechem/repository/apiservices.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'personaldetailslist_event.dart';
part 'personaldetailslist_state.dart';

class PersonaldetailslistBloc
    extends Bloc<PersonaldetailslistEvent, PersonaldetailslistState> {
  final ApiServices apiServices;
  PersonaldetailslistBloc(this.apiServices)
    : super(PersonaldetailslistInitial()) {
    on<CallPersonalDetailsApiEvent>(callPersonalDetailsApi);
  }
  Future<void> callPersonalDetailsApi(
    CallPersonalDetailsApiEvent event,
    emit,
  ) async {
    emit(PersonaldetailslistLoading());
    try {
      PersonalDetails response = await apiServices.fetchPersonalDetails();
      emit(PersonaldetailslistSuccess(data: response));
      return;
    } catch (e) {
      emit(PersonaldetailslistFailure());
    }
  }
}
