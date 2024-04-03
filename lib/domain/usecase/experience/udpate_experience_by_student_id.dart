import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/experiences/experience_list.dart';
import 'package:boilerplate/domain/repository/experiences/experience_repository.dart';

class UpdateExperienceByStudentIdUseCase
    extends UseCase<ExperienceList, ExperienceList> {
  final ExperienceRepository _experienceRepository;

  UpdateExperienceByStudentIdUseCase(this._experienceRepository);

  @override
  Future<ExperienceList> call({required ExperienceList params}) {
    return _experienceRepository.updateExperienceByStudentId(params);
  }
}
