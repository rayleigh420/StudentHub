import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}

class StudentHubLoginUC extends UseCase<String, LoginParams> {
  final AuthRepository _authRepository;

  StudentHubLoginUC(this._authRepository);

  @override
  Future<String> call({required params}) {
    return _authRepository.signInWithStudentHub(
        params.username, params.password);
  }
}
