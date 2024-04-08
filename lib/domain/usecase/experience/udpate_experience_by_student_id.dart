import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/experiences/experience_list.dart';
import 'package:boilerplate/domain/repository/experiences/experience_repository.dart';

class UpdateExperienceByStudentIdUseCase
    extends UseCase<ExperienceList, ExperienceReqList> {
  final ExperienceRepository _experienceRepository;

  UpdateExperienceByStudentIdUseCase(this._experienceRepository);

  @override
  Future<ExperienceList> call({required ExperienceReqList params}) {
    return _experienceRepository.updateExperienceByStudentId(params);
  }
}
