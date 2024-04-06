import 'package:boilerplate/data/network/apis/languages/language_api.dart';
import 'package:boilerplate/domain/entity/language/language_student_list.dart';
import 'package:boilerplate/domain/repository/languages/language_repository.dart';

class LanguageRepositoryImpl extends LanguageRepository {
  final LanguageApi _languageApi;

  // Use shareHelper to get student id
  int studentId = 23;

  LanguageRepositoryImpl(this._languageApi);

  @override
  Future<LanguageStudentList> getLanguageByStudentId() async {
    try {
      LanguageStudentList result =
          await _languageApi.getLanguageByStudentId(studentId);
      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  Future<LanguageStudentList> updateLanguageByStudentId(
      LanguageStudentList languageStudentList) async {
    try {
      LanguageStudentList result = await _languageApi.updateLanguageByStudentId(
          studentId, languageStudentList);
      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
