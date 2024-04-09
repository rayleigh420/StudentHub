import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/apis/profile/profile_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/profile/profile.dart';
import 'package:boilerplate/domain/repository/profile/profile_repository.dart';

class ProfileUserRepositoryImpl extends ProfileUserRepository {
  final ProfileApi _profileApi;
  final SharedPreferenceHelper _sharedPrefsHelper;
  ProfileUserRepositoryImpl(this._profileApi, this._sharedPrefsHelper);

  @override
  Future<Profile> getProfile() async {
    try {
      // final token = await _sharedPrefsHelper.authToken;
      final res = await _profileApi.getProfile();
      log("profile from profile user rep imp");
      print("profile from profile user rep imp");
      res.getTypes();
      if (res.company != null) {
        _sharedPrefsHelper.saveCurrentCompanyId(res.company!.id);
        _sharedPrefsHelper.removeCurrentStudentId();
      } else {
        _sharedPrefsHelper.saveCurrentStudentId(res.student!.id);
        _sharedPrefsHelper.removeCurrentCompanyId();
      }
      _sharedPrefsHelper.saveRolesUser(res.roles);
      return res;
    } catch (e) {
      log("cc");
      throw new Exception(e.toString());
    }
    // return Profile(id: 1, fullname: "2", roles: ["1"]);
  }
}
