import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/educations/education_list.dart';
import 'package:boilerplate/domain/repository/educations/education_repository.dart';

class GetEducationByStudentIdUseCase extends UseCase<EducationList, void> {
  final EducationRepository _educationRepository;

  GetEducationByStudentIdUseCase(this._educationRepository);

  @override
  Future<EducationList> call({required params}) {
    return _educationRepository.getEducationByStudentId();
  }
}
