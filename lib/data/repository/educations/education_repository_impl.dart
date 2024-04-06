import 'package:boilerplate/data/network/apis/educations/education_api.dart';
import 'package:boilerplate/domain/entity/educations/education_list.dart';
import 'package:boilerplate/domain/repository/educations/education_repository.dart';

class EducationRepositoryImpl extends EducationRepository {
  final EducationApi _educationApi;

  // Use shareHelper to get student id
  int studentId = 23;

  EducationRepositoryImpl(this._educationApi);

  @override
  Future<EducationList> getEducationByStudentId() async {
    try {
      EducationList result =
          await _educationApi.getEducationByStudentId(studentId);
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
      EducationList result = await _educationApi.updateEducationByStudentId(
          studentId, educationList);
      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
