import 'package:boilerplate/data/network/apis/experiences/experience_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/experiences/experience_list.dart';
import 'package:boilerplate/domain/repository/experiences/experience_repository.dart';

class ExperienceRepositoryImpl extends ExperienceRepository {
  final ExperienceApi _experienceApi;
  final SharedPreferenceHelper _sharedPrefsHelper;

  ExperienceRepositoryImpl(this._experienceApi, this._sharedPrefsHelper);

  @override
  Future<ExperienceList> getExperienceByStudentId() async {
    try {
      int? studentId = await _sharedPrefsHelper.currentStudentId;
      ExperienceList result =
          await _experienceApi.getExperienceByStudentId(studentId!);
      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  Future<ExperienceList> updateExperienceByStudentId(
      ExperienceReqList experienceList) async {
    try {
      int? studentId = await _sharedPrefsHelper.currentStudentId;
      print(studentId);
      ExperienceList result = await _experienceApi.updateExperienceByStudentId(
          studentId!, experienceList);
      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
