import 'package:boilerplate/domain/entity/educations/education.dart';
import 'package:boilerplate/domain/entity/language/language_student.dart';

class EducationList {
  final List<Education>? educations;

  EducationList({
    this.educations,
  });

  factory EducationList.fromJson(Map<String, dynamic> json) {
    List<Education> educations = <Education>[];
    educations = List.from(
        json['result'].map((education) => Education.fromMap(education)));

    return EducationList(
      educations: educations,
    );
  }
}
