import 'package:boilerplate/data/network/apis/auth/auth_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';

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

      _sharedPrefsHelper.saveAuthToken(token);
      _sharedPrefsHelper.saveIsLoggedIn(true);
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
      _sharedPrefsHelper.removeAuthToken();
      _sharedPrefsHelper.removeCurrentCompanyId();
      _sharedPrefsHelper.removeCurrentStudentId();
      _sharedPrefsHelper.removeRolesUser();
      _sharedPrefsHelper.saveIsLoggedIn(false);
    } catch (e) {
      throw new Exception(e.toString());
    }
  }
}
