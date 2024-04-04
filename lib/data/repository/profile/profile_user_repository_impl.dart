import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/apis/profile/profile_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/profile/profile.dart';
import 'package:boilerplate/domain/repository/profile/profile_repository.dart';

class ProfileUserRepositoryImpl extends ProfileUserRepository {
  final ProfileApi _profileApi;

  ProfileUserRepositoryImpl(this._profileApi);

  @override
  Future<Profile> getProfile() async {
    try {
      // final token = await _sharedPrefsHelper.authToken;
      final res = await _profileApi.getProfile();
      return res;
    } catch (e) {
      throw new Exception(e.toString());
    }
    // return Profile(id: 1, fullname: "2", roles: ["1"]);
  }
}
