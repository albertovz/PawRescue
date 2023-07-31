abstract class UpdateEvent {}

class UpdateUserProfileEvent extends UpdateEvent {
  final Map<String, dynamic> data;

  UpdateUserProfileEvent(this.data);
}
