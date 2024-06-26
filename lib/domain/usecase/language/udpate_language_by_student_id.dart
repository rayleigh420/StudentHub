import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/language/language_student.dart';
import 'package:boilerplate/domain/entity/language/language_student_list.dart';
import 'package:boilerplate/domain/repository/languages/language_repository.dart';

class UpdateLanguageByStudentIdUseCase
    extends UseCase<LanguageStudentList, LanguageStudentList> {
  final LanguageRepository _languageRepository;

  UpdateLanguageByStudentIdUseCase(this._languageRepository);

  @override
  Future<LanguageStudentList> call({required LanguageStudentList params}) {
    return _languageRepository.updateLanguageByStudentId(params);
  }
}
