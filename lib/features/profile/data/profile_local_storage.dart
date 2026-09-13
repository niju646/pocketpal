import 'package:hive/hive.dart';
import 'package:pocket_pal/features/profile/data/profile_model.dart';

class ProfileLocalStorage {
  final Box box = Hive.box('profile');

  Future<void> saveProfile(ProfileModel profile) async {
    await box.put('profile', profile.toMap());
  }

  ProfileModel? getProfile() {
    final data = box.get('profile');

    if (data == null) {
      return null;
    }

    return ProfileModel.fromMap(data);
  }

  Future<void> clearProfile() async {
    await box.clear();
  }
}
