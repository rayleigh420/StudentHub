import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/profile/profile_student_repository.dart';

class CreateProfileStudentParams {
  final int techStackId;
  final List<String> skillSets;
  CreateProfileStudentParams({
    required this.techStackId,
    required this.skillSets,
  });
}

class CreateProfileStudentUC extends UseCase<bool, CreateProfileStudentParams> {
  final ProfileStudentRepository _profileStudentRepository;

  CreateProfileStudentUC(this._profileStudentRepository);

  @override
  Future<bool> call({required params}) {
    return _profileStudentRepository.createProfileStudent(
        params.techStackId, params.skillSets);
  }
}
