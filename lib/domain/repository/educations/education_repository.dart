import 'package:boilerplate/domain/entity/educations/education_list.dart';

abstract class EducationRepository {
  Future<EducationList> getEducationByStudentId();

  Future<EducationList> updateEducationByStudentId(EducationList educationList);
}
