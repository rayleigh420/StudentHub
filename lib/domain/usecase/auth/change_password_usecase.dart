import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';

class ChangePasswordParams {
  final String oldPassword;
  final String newPassword;

  ChangePasswordParams({required this.oldPassword, required this.newPassword});
}

class ChangePasswordUC extends UseCase<bool, ChangePasswordParams> {
  final AuthRepository _authRepository;

  ChangePasswordUC(this._authRepository);

  @override
  Future<bool> call({required params}) {
    return _authRepository.changePassword(
        params.oldPassword, params.newPassword);
  }
}
