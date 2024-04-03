import 'package:boilerplate/domain/entity/language/language_student.dart';
import 'package:boilerplate/domain/entity/language/language_student_list.dart';

abstract class LanguageRepository {
  Future<LanguageStudentList> getLanguageByStudentId();

  Future<LanguageStudentList> updateLanguageByStudentId(
      LanguageStudentList languageStudentList);
}
