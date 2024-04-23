import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/features/profile/domain/entities/profile_entity.dart';
import 'package:tak/features/profile/domain/entities/profile_photo_entity.dart';
import 'package:tak/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:tak/features/profile/domain/usecases/update_profile_image_usecase.dart';
import 'package:tak/features/profile/domain/usecases/update_profile_usecase.dart';

part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UpdateProfileUseCase updateProfileUseCase;
  UpdateProfileImageUseCase updateProfileImageUseCase;
  ChangePasswordUseCase changePasswordUseCase;
  ProfileBloc({
    required this.updateProfileUseCase,
    required this.updateProfileImageUseCase,
    required this.changePasswordUseCase,
  }) : super(ProfileInitialState()) {
    on<ProfileUpdateEvent>((event, emit) => profileUpdateEvent(event, emit));
    on<ProfileUpdateImageEvent>(
        (event, emit) => profileUpdateImageEvent(event, emit));
    on<ChangePasswordEvent>((event, emit) => changePasswordEvent(event, emit));
  }

  changePasswordEvent(event, emit) async {
    emit(ProfileLoadingState());
    final failureOrChangePassword = await changePasswordUseCase(
      ChangePasswordParams(
        password: event.password,
      ),
    );

    emit(failureOrChangePassword.fold(
        (failure) => ProfileErrorState(message: mapFailureToMessage(failure)),
        (profileEntity) => ProfileUpdateState(profileEntity: profileEntity)));
  }

  profileUpdateImageEvent(event, emit) async {
    final failureOrCreateAccount = await updateProfileImageUseCase(
      ProfilePhotoParams(
        path: event.path,
      ),
    );

    emit(failureOrCreateAccount.fold(
        (failure) => ProfileErrorState(message: mapFailureToMessage(failure)),
        (photoEntity) => ProfilePhotoUpdateState(photoEntity: photoEntity)));
  }

  profileUpdateEvent(event, emit) async {
    emit(ProfileLoadingState());

    final failureOrCreateAccount = await updateProfileUseCase(
      ProfileParams(
        name: event.name,
        gender: event.gender,
        telephone: event.telephone,
      ),
    );
    emit(failureOrCreateAccount.fold(
        (failure) => ProfileErrorState(message: mapFailureToMessage(failure)),
        (profileEntity) => ProfileUpdateState(profileEntity: profileEntity)));
  }
}
