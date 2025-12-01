import 'package:beechem/models/personaldetailsaddresponse.dart';
import 'package:beechem/repository/apiservices.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'personaldetailsadd_event.dart';
part 'personaldetailsadd_state.dart';

class PersonaldetailsaddBloc
    extends Bloc<PersonaldetailsaddEvent, PersonaldetailsaddState> {
  final ApiServices apiServices;
  PersonaldetailsaddBloc(this.apiServices)
    : super(PersonaldetailsaddInitial()) {
    on<CallPersonalDetailsAddApiEvent>(callPersonaldetailsAdd);
  }

  Future<void> callPersonaldetailsAdd(
    CallPersonalDetailsAddApiEvent event,
    emit,
  ) async {
    emit(PersonaldetailsaddLoading());
    try {
      PersonalDetailsAddResponse response = await apiServices
          .addPersonalDetails(
            firstName: event.firstName,
            address: event.address,
            suburb: event.suburb,
            state: event.state,
            postcode: event.postcode,
            contactNumber: event.contactNumber,
            status: event.status,
          );
      emit(PersonaldetailsaddSuccess(data: response));
      return;
    } catch (e) {
      emit(PersonaldetailsaddFailure());
    }
  }
}
