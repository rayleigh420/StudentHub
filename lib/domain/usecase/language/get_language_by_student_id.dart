import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/language/language_student_list.dart';
import 'package:boilerplate/domain/repository/languages/language_repository.dart';

class GetLanguageByStudentIdUseCase extends UseCase<LanguageStudentList, void> {
  final LanguageRepository _languageRepository;

  GetLanguageByStudentIdUseCase(this._languageRepository);

  @override
  Future<LanguageStudentList> call({required params}) {
    return _languageRepository.getLanguageByStudentId();
  }
}
