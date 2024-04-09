import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';

class SignUpParams {
  final String email;
  final String password;
  final String fullName;
  final int role;

  SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.role,
  });
}

class StudentHubSignupUC extends UseCase<bool, SignUpParams> {
  final AuthRepository _authRepository;

  StudentHubSignupUC(this._authRepository);

  @override
  Future<bool> call({required params}) {
    return _authRepository.signUpStudentHub(
        params.email, params.password, params.fullName, params.role);
  }
}
