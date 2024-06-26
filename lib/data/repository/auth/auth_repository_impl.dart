import 'package:boilerplate/data/network/apis/auth/auth_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthRepositoryImpl extends AuthRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;
  final AuthApi _authApi;
  // constructor
  AuthRepositoryImpl(this._authApi, this._sharedPrefsHelper);

  // Login:---------------------------------------------------------------------
  @override
  Future<String> signInWithStudentHub(String email, String password) async {
    try {
      final token = await _authApi.logIn(email, password);
      final jwt = JWT.decode(token);
      final id = jwt.payload['id'];
      await _sharedPrefsHelper.saveAuthToken(token);
      await _sharedPrefsHelper.saveIsLoggedIn(true);
      await _sharedPrefsHelper.saveDefaultId(id);
      return token;
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  @override
  Future<String> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<String> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<String> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<bool> signUpStudentHub(
      String email, String password, String fullName, int roles) async {
    try {
      final res = await _authApi.signUp(email, password, fullName, roles);

      return res;
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  @override
  Future<void> saveIsLoggedIn(bool value) {
    // TODO: implement saveIsLoggedIn
    _sharedPrefsHelper.saveIsLoggedIn(value);
    throw UnimplementedError();
  }

  @override
  Future<String> testToken() async {
    try {
      final token = await _authApi.testToken();
      return token;
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _authApi.logOut();
      await _sharedPrefsHelper.removeAuthToken();
      await _sharedPrefsHelper.removeCurrentCompanyId();
      await _sharedPrefsHelper.removeCurrentStudentId();
      await _sharedPrefsHelper.removeRolesUser();
      await _sharedPrefsHelper.saveIsLoggedIn(false);
      await _sharedPrefsHelper.removeDefaultId();
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  @override
  Future<bool> changePassword(String oldPassword, String newPassword) {
    try {
      final res = _authApi.changePassword(oldPassword, newPassword);
      return res;
    } catch (e) {
      throw new Exception(e.toString());
    }
  }
}
