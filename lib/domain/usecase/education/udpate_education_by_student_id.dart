import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/educations/education_list.dart';
import 'package:boilerplate/domain/repository/educations/education_repository.dart';

class UpdateEducationByStudentIdUseCase
    extends UseCase<EducationList, EducationList> {
  final EducationRepository _educationRepository;

  UpdateEducationByStudentIdUseCase(this._educationRepository);

  @override
  Future<EducationList> call({required EducationList params}) {
    return _educationRepository.updateEducationByStudentId(params);
  }
}
