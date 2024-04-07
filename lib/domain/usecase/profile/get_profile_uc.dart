import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/profile/profile.dart';
import 'package:boilerplate/domain/repository/profile/profile_repository.dart';

class GetProfileUseCase extends UseCase<Profile, void> {
  final ProfileUserRepository _profileRepository;

  GetProfileUseCase(this._profileRepository);

  Future<Profile> call({required void params}) {
    try {
      return _profileRepository.getProfile();
    } catch (e) {
      throw e;
    }
  }
}
