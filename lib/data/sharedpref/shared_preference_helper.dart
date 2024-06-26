import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<int?> get currentCompanyId async {
    return _sharedPreference.getInt(Preferences.current_company_id);
  }

  Future<int?> get currentStudentId async {
    return _sharedPreference.getInt(Preferences.current_student_id);
  }

  Future<int?> get defaultId async {
    return _sharedPreference.getInt(Preferences.default_id);
  }

  Future<List<int>?> get roles async {
    return _sharedPreference
        .getStringList(Preferences.roles)
        ?.map((e) => int.parse(e))
        .toList();
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }

  // Id profile
  Future<bool> saveCurrentCompanyId(int companyId) async {
    return _sharedPreference.setInt(Preferences.current_company_id, companyId);
  }

  Future<bool> removeCurrentCompanyId() async {
    return _sharedPreference.remove(Preferences.current_company_id);
  }

  Future<bool> saveCurrentStudentId(int userId) async {
    return _sharedPreference.setInt(Preferences.current_student_id, userId);
  }

  Future<bool> removeCurrentStudentId() async {
    return _sharedPreference.remove(Preferences.current_student_id);
  }

  // Roles User
  Future<bool> saveRolesUser(List<int> roles) async {
    return _sharedPreference.setStringList(
        Preferences.roles, roles.map((e) => e.toString()).toList());
  }

  Future<bool> removeRolesUser() async {
    return _sharedPreference.remove(Preferences.roles);
  }

  Future<bool> saveDefaultId(int id) async {
    return _sharedPreference.setInt(Preferences.default_id, id);
  }

  Future<int?> getDefaultId() async {
    return _sharedPreference.getInt(Preferences.default_id);
  }

  Future<bool> removeDefaultId() async {
    return _sharedPreference.remove(Preferences.default_id);
  }
}
