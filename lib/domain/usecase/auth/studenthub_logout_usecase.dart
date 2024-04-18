import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';
import 'package:boilerplate/domain/usecase/auth/studenthub_login_usecase.dart';

class StudentHubLogoutUC extends UseCase<void, void> {
  final AuthRepository _authRepository;

  StudentHubLogoutUC(this._authRepository);

  @override
  Future<void> call({required params}) {
    return _authRepository.logOut();
  }
}
