abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String firstName;
  final String lastName;
  // Agregar los demás campos

  RegisterButtonPressed({
    required this.firstName,
    required this.lastName,
    // Agregar los demás campos
  });
}
