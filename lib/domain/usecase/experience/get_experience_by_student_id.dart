import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/experiences/experience_list.dart';
import 'package:boilerplate/domain/repository/experiences/experience_repository.dart';

class GetExperienceByStudentIdUseCase extends UseCase<ExperienceList, void> {
  final ExperienceRepository _experienceRepository;

  GetExperienceByStudentIdUseCase(this._experienceRepository);

  @override
  Future<ExperienceList> call({required params}) {
    return _experienceRepository.getExperienceByStudentId();
  }
}
