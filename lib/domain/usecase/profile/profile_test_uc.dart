import 'package:boilerplate/domain/repository/auth/auth_repository.dart';

class ProfileTestUC {
  final AuthRepository _authRepository;
  ProfileTestUC(this._authRepository);
  Future<String> call() {
    return _authRepository.testToken();
  }
}
