abstract class AuthRepository {
  Future<String> signInWithGoogle();
  Future<String> signInWithFacebook();
  Future<String> signInWithApple();
  Future<String> signInWithStudentHub(String email, String password);

  Future<String> signUpStudentHub(
      String email, String password, String fullName, int roles);
  Future<void> saveIsLoggedIn(bool value);
  Future<String> testToken();
}
