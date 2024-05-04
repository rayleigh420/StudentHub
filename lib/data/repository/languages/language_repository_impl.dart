import 'package:boilerplate/data/network/apis/languages/language_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/language/language_student_list.dart';
import 'package:boilerplate/domain/repository/languages/language_repository.dart';

class LanguageRepositoryImpl extends LanguageRepository {
  final LanguageApi _languageApi;
  final SharedPreferenceHelper _sharedPrefsHelper;

  LanguageRepositoryImpl(this._languageApi, this._sharedPrefsHelper);

  @override
  Future<LanguageStudentList> getLanguageByStudentId() async {
    try {
      int? studentId = await _sharedPrefsHelper.currentStudentId;
      LanguageStudentList result =
          await _languageApi.getLanguageByStudentId(studentId!);
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
      int? studentId = await _sharedPrefsHelper.currentStudentId;
      LanguageStudentList result = await _languageApi.updateLanguageByStudentId(
          studentId!, languageStudentList);
      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
