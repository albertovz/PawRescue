import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paw/User/Auth/ApiService.dart';
import './register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();
      try {
        // Aquí puedes realizar las operaciones de registro y la lógica de comunicación con ApiService
        Map<String, dynamic> data = {
          'name': event.firstName,
          'lastName': event.lastName,
          // Agregar los demás campos
        };

        // Hacer la solicitud POST al backend de React
        await ApiService.registerUser(data);

        yield RegisterSuccess();
      } catch (error) {
        yield RegisterFailure(error.toString());
      }
    }
  }
}
