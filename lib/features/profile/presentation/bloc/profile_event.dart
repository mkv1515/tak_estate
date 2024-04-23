part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {}

class ProfileUpdateEvent extends ProfileEvent {
  final String name;
  final String gender;
  final String telephone;

  ProfileUpdateEvent({
    required this.name,
    required this.gender,
    required this.telephone,
  });
  @override
  List<Object?> get props => [name, gender, telephone];
}

class ChangePasswordEvent extends ProfileEvent {
  final String password;

  ChangePasswordEvent({
    required this.password,
  });
  @override
  List<Object?> get props => [
        password,
      ];
}

class ProfileUpdateImageEvent extends ProfileEvent {
  final String path;

  ProfileUpdateImageEvent({required this.path});

  @override
  List<Object?> get props => throw [path];
}
