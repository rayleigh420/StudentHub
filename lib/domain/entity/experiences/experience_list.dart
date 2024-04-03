import 'package:boilerplate/domain/entity/experiences/experience.dart';

class ExperienceList {
  final List<Experience>? experiences;

  ExperienceList({
    this.experiences,
  });

  factory ExperienceList.fromJson(Map<String, dynamic> json) {
    List<Experience> experiences = <Experience>[];
    experiences = List.from(
        json['result'].map((experience) => Experience.fromMap(experience)));

    return ExperienceList(
      experiences: experiences,
    );
  }
}
