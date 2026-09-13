import 'dart:developer';

import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/features/profile/data/profile_local_storage.dart';
import 'package:pocket_pal/features/profile/data/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    loadProfile();
  }

  ProfileModel? profile;
  final ProfileLocalStorage localStorage = ProfileLocalStorage();

  void loadProfile() {
    try {
      final savedProfile = localStorage.getProfile();

      if (savedProfile != null) {
        profile = savedProfile;

        log('Name: ${profile?.name}');
        log('Email: ${profile?.email}');

        emit(ProfileSuccess(profileModel: profile!));
      } else {
        emit(ProfileInitial());
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    try {
      emit(ProfileLoading());

      profile = ProfileModel(name: name, email: email);

      await localStorage.saveProfile(profile!);

      log('Name: ${profile?.name}');
      log('Email: ${profile?.email}');

      emit(ProfileSuccess(profileModel: profile!));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> clearProfile() async {
    try {
      await localStorage.clearProfile();

      profile = null;

      emit(ProfileInitial());
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  //get profile
  Future<void> getProfile() async {
    try {
      emit(ProfileLoading());

      if (profile != null) {
        emit(ProfileSuccess(profileModel: profile!));
      } else {
        emit(ProfileInitial());
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
