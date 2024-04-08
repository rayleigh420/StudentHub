import 'package:boilerplate/domain/entity/experiences/experience_list.dart';

abstract class ExperienceRepository {
  Future<ExperienceList> getExperienceByStudentId();

  Future<ExperienceList> updateExperienceByStudentId(
      ExperienceReqList experienceList);
}
