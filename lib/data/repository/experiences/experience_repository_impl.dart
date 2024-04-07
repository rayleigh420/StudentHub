import 'package:boilerplate/data/network/apis/experiences/experience_api.dart';
import 'package:boilerplate/domain/entity/experiences/experience_list.dart';
import 'package:boilerplate/domain/repository/experiences/experience_repository.dart';

class ExperienceRepositoryImpl extends ExperienceRepository {
  final ExperienceApi _experienceApi;

  // Use shareHelper to get student id
  int studentId = 23;

  ExperienceRepositoryImpl(this._experienceApi);

  @override
  Future<ExperienceList> getExperienceByStudentId() async {
    try {
      ExperienceList result =
          await _experienceApi.getExperienceByStudentId(studentId);
      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  Future<ExperienceList> updateExperienceByStudentId(
      ExperienceList experienceList) async {
    try {
      ExperienceList result = await _experienceApi.updateExperienceByStudentId(
          studentId, experienceList);
      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
