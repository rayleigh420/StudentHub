import 'package:boilerplate/data/network/apis/educations/education_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/educations/education_list.dart';
import 'package:boilerplate/domain/repository/educations/education_repository.dart';

class EducationRepositoryImpl extends EducationRepository {
  final EducationApi _educationApi;
  final SharedPreferenceHelper _sharedPrefsHelper;

  EducationRepositoryImpl(this._educationApi, this._sharedPrefsHelper);

  @override
  Future<EducationList> getEducationByStudentId() async {
    try {
      int? studentId = await _sharedPrefsHelper.currentStudentId;
      EducationList result =
          await _educationApi.getEducationByStudentId(studentId!);
      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  Future<EducationList> updateEducationByStudentId(
      EducationList educationList) async {
    try {
      int? studentId = await _sharedPrefsHelper.currentStudentId;
      EducationList result = await _educationApi.updateEducationByStudentId(
          studentId!, educationList);
      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
